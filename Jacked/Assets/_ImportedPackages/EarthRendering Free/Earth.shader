// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "Planet"
{
	Properties 
	{
		_AtmosphereColor ("Atmosphere Color", Color) = (0.1, 0.35, 1.0, 1.0)
		_AtmospherePow ("Atmosphere Power", Range(1.5, 8)) = 2
		_AtmosphereMultiply ("Atmosphere Multiply", Range(1, 3)) = 1.5

		_DiffuseTex("Diffuse", 2D) = "white" {}
		_SpecularTex("Specular", 2D) = "white" {}
		
		_CloudAndNightTex("Cloud And Night", 2D) = "black" {}

		_LightDir("Light Dir", Vector) = (-1,0,0,1)
		_ShadowLift("Shadow Lift", Range(0,1)) = 0.01

		_SpecColor ("Specular Material Color", Color) = (1,1,1,1) 
		_Shininess ("Shininess", Float) = 10

		_Contrast("Contrast", Range(0, 25)) = 0.5
		_Lift("Lift", Range(-25,25)) = 0.5

		_SpecularFadeContrast("SpecFadeContrast", Range(0, 25)) = 10
		_SpecularFadeLift("SpecFadeLift", Range(-25, 25)) = -9.81
	}

	SubShader 
	{
		ZWrite On
		ZTest LEqual

		pass
		{
		CGPROGRAM
			#include "UnityCG.cginc"
			#pragma vertex vert 
			#pragma fragment frag
			
			sampler2D _DiffuseTex;
			sampler2D _SpecularTex;
			sampler2D _CloudAndNightTex;

			uniform float4 _SpecColor; 
			uniform float _Shininess;

			float4 _AtmosphereColor;
			float _AtmospherePow;
			float _AtmosphereMultiply;
			float _ShadowLift;
			float _Contrast;
			float _Lift;
			float _SpecularFadeContrast;
			float _SpecularFadeLift;

			float4 _LightDir;

			struct vertexInput 
			{
				float4 pos				: POSITION;
				float3 normal			: NORMAL;
				float2 uv				: TEXCOORD0;
			};

			struct vertexOutput 
			{
				float4 pos			: POSITION;
				float2 uv			: TEXCOORD0;
				half diffuse		: TEXCOORD1;
				half night			: TEXCOORD2;
				half3 atmosphere	: TEXCOORD3;
				float4 posWorld : TEXCOORD4;
				float3 normalDir : TEXCOORD5;
			};
			
			vertexOutput vert(vertexInput input) 
			{
				vertexOutput output;
				output.pos = mul(UNITY_MATRIX_MVP, input.pos);
				output.uv = input.uv;

				output.diffuse = saturate(dot(_LightDir.xyz, input.normal) * 1.2);
				output.night = 1 - saturate(output.diffuse * 2);

				half3 viewDir = normalize(ObjSpaceViewDir(input.pos));
				half3 normalDir = input.normal;
				output.atmosphere = output.diffuse * _AtmosphereColor.rgb * pow(1 - saturate(dot(viewDir, normalDir)), _AtmospherePow) * _AtmosphereMultiply;

				float4x4 modelMatrix = unity_ObjectToWorld;
				float4x4 modelMatrixInverse = unity_WorldToObject; 
 
				output.posWorld = mul(modelMatrix, input.pos);
				output.normalDir = normalize(mul(float4(input.normal, 0.0), modelMatrixInverse).xyz);

				return output;
			}

			half4 frag(vertexOutput input) : Color
			{
				half4 result;
				half3 colorSample = tex2D(_DiffuseTex, input.uv).rgb;
				half specSample = 1- tex2D(_SpecularTex, input.uv).r;
				half3 cloudAndNightSample = tex2D(_CloudAndNightTex, input.uv).rgb;
				half3 nightSample = cloudAndNightSample.ggb;
				half cloudSample = cloudAndNightSample.r;
				
				specSample = clamp((specSample - 0.5f) * (_Contrast) + 0.5f - _Lift, 0, 1);

				result.rgb = (colorSample + cloudSample) * clamp(input.diffuse + _ShadowLift, 0, 1)  + input.atmosphere;
				result.a = 1;

				float3 normalDirection = normalize(input.normalDir);
				float3 viewDirection = normalize(_WorldSpaceCameraPos - input.posWorld.xyz);
				float3 lightDirection;
				float attenuation;
 
				if (0.0 == _LightDir.w) // directional light?
				{
				   attenuation = 1.0; // no attenuation
				   lightDirection = normalize(_LightDir.xyz);
				} 
 
				float3 ambientLighting = UNITY_LIGHTMODEL_AMBIENT.rgb * result.rgb;
				float3 diffuseReflection = attenuation * result.rgb * max(0.0, dot(normalDirection, lightDirection));
				float3 specularReflection;
				 
				float dotedDir = dot(normalDirection, lightDirection);
				
				if (dotedDir < 0.0) // light source on the wrong side?
				{
				   specularReflection = float3(0.0, 0.0, 0.0); // no specular reflection
				}
				else // light source on the right side
				{
				   specularReflection = attenuation 
					  * _SpecColor.rgb 
					  * pow(max(0.0, dot(reflect(-lightDirection, normalDirection), viewDirection)), _Shininess);
				}

				float multr = clamp((dotedDir - 0.5f) * (_SpecularFadeContrast) + 0.5f - _SpecularFadeLift, 0, 1);
				specularReflection *= specSample * multr;

				result = float4(ambientLighting + diffuseReflection + specularReflection, 1.0);
				return result;

			}
		ENDCG
		}
	}
	
	Fallback "Diffuse"
}