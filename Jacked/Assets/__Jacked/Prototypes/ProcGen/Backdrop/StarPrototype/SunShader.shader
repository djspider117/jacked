// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

// Shader created with Shader Forge v1.30 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.30;sub:START;pass:START;ps:flbk:Unlit/Texture,iptp:0,cusa:False,bamd:0,lico:1,lgpr:1,limd:0,spmd:0,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False;n:type:ShaderForge.SFN_Final,id:6671,x:34669,y:32089,varname:node_6671,prsc:2|emission-4713-OUT;n:type:ShaderForge.SFN_Fresnel,id:7471,x:32999,y:31681,varname:fresnelOut,prsc:2|EXP-4155-OUT;n:type:ShaderForge.SFN_Tex2d,id:1210,x:33517,y:32141,ptovrint:True,ptlb:Diffuse,ptin:_Diffuse,varname:_Diffuse,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:7088d64676f52064ba3e62397272a9c0,ntxv:3,isnm:False;n:type:ShaderForge.SFN_Add,id:4713,x:34412,y:32069,varname:node_4713,prsc:2|A-5458-OUT,B-8756-OUT;n:type:ShaderForge.SFN_Color,id:2369,x:32593,y:31947,ptovrint:True,ptlb:Fresnell Color,ptin:_FresnellColor,varname:_FresnellColor,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.9926471,c2:0.9050605,c3:0.7736808,c4:1;n:type:ShaderForge.SFN_Multiply,id:5458,x:33217,y:31792,varname:node_5458,prsc:2|A-7471-OUT,B-2369-RGB;n:type:ShaderForge.SFN_Slider,id:4155,x:32512,y:31726,ptovrint:True,ptlb:Fresnel IOR,ptin:_iOR,varname:_iOR,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1.709402,max:5;n:type:ShaderForge.SFN_Code,id:5285,x:32234,y:32833,varname:node_5285,prsc:2,code:ZgBsAG8AYQB0ACAAcgBlAHQAIAA9ACAAMAA7AA0ACgBpAG4AdAAgAGkAdABlAHIAYQB0AGkAbwBuAHMAIAA9ACAASQB0AGUAcgBhAHQAaQBvAG4AcwA7AA0ACgBmAG8AcgAgACgAaQBuAHQAIABpACAAPQAgADAAOwAgAGkAIAA8ACAAaQB0AGUAcgBhAHQAaQBvAG4AcwA7ACAAKwArAGkAKQANAAoAewANAAoAIAAgACAAZgBsAG8AYQB0ADIAIABwACAAPQAgAGYAbABvAG8AcgAoAFUAVgAgACoAIAAoAGkAKwAxACkAKQA7AA0ACgAgACAAIABmAGwAbwBhAHQAMgAgAGYAIAA9ACAAZgByAGEAYwAoAFUAVgAgACoAIAAoAGkAKwAxACkAKQA7AA0ACgAgACAAIABmACAAPQAgAGYAIAAqACAAZgAgACoAIAAoADMALgAwACAALQAgADIALgAwACAAKgAgAGYAKQA7AA0ACgAgACAAIABmAGwAbwBhAHQAIABuACAAPQAgAHAALgB4ACAAKwAgAHAALgB5ACAAKgAgADUANwAuADAAOwANAAoAIAAgACAAZgBsAG8AYQB0ADQAIABuAG8AaQBzAGUAIAA9ACAAZgBsAG8AYQB0ADQAKABuACwAIABuACAAKwAgADEALAAgAG4AIAArACAANQA3AC4AMAAsACAAbgAgACsAIAA1ADgALgAwACkAOwANAAoAIAAgACAAbgBvAGkAcwBlACAAPQAgAGYAcgBhAGMAKABzAGkAbgAoAG4AbwBpAHMAZQApACoAUwBlAGUAZAApADsADQAKACAAIAAgAHIAZQB0ACAAKwA9ACAAbABlAHIAcAAoAGwAZQByAHAAKABuAG8AaQBzAGUALgB4ACwAIABuAG8AaQBzAGUALgB5ACwAIABmAC4AeAApACwAIABsAGUAcgBwACgAbgBvAGkAcwBlAC4AegAsACAAbgBvAGkAcwBlAC4AdwAsACAAZgAuAHgAKQAsACAAZgAuAHkAKQAgACoAIAAoACAAaQB0AGUAcgBhAHQAaQBvAG4AcwAgAC8AIAAoAGkAKwAxACkAKQA7AA0ACgB9AA0ACgByAGUAdAB1AHIAbgAgAHIAZQB0AC8AaQB0AGUAcgBhAHQAaQBvAG4AcwA7AA==,output:0,fname:noise,width:899,height:329,input:1,input:8,input:0,input_1_label:UV,input_2_label:Iterations,input_3_label:Seed|A-5962-OUT,B-9289-OUT,C-2542-OUT;n:type:ShaderForge.SFN_TexCoord,id:1202,x:31781,y:32673,varname:node_1202,prsc:2,uv:0;n:type:ShaderForge.SFN_Multiply,id:5962,x:31991,y:32839,varname:node_5962,prsc:2|A-1202-UVOUT,B-2818-OUT;n:type:ShaderForge.SFN_ValueProperty,id:2818,x:31735,y:32960,ptovrint:True,ptlb:Noise Scale,ptin:_NoiseUV,varname:_NoiseUV,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:56;n:type:ShaderForge.SFN_ConstantLerp,id:7234,x:33623,y:32631,varname:node_7234,prsc:2,a:0,b:0.5|IN-4402-OUT;n:type:ShaderForge.SFN_Lerp,id:2629,x:33863,y:32465,varname:node_2629,prsc:2|A-4027-RGB,B-6069-RGB,T-7234-OUT;n:type:ShaderForge.SFN_Color,id:4027,x:32586,y:32223,ptovrint:True,ptlb:Color1,ptin:_Color1,varname:_Color1,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:0.5878296,c3:0.06617647,c4:1;n:type:ShaderForge.SFN_Color,id:6069,x:32586,y:32443,ptovrint:False,ptlb:Color2,ptin:_Color2,varname:_Color2,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:0.8068966,c3:0,c4:1;n:type:ShaderForge.SFN_Slider,id:9289,x:31754,y:33130,ptovrint:True,ptlb:Noise Complexity,ptin:_NoiseComplexity,varname:_NoiseComplexity,prsc:0,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:10;n:type:ShaderForge.SFN_ValueProperty,id:2542,x:31881,y:33322,ptovrint:False,ptlb:Seed,ptin:_Seed,varname:_Seed,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:437.5854;n:type:ShaderForge.SFN_Power,id:4402,x:33430,y:32663,varname:node_4402,prsc:2|VAL-5285-OUT,EXP-838-OUT;n:type:ShaderForge.SFN_Slider,id:838,x:33197,y:33083,ptovrint:True,ptlb:Contrast,ptin:_Contrast,varname:_Contrast,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-10,cur:-2.61,max:10;n:type:ShaderForge.SFN_SwitchProperty,id:8756,x:34142,y:32192,ptovrint:False,ptlb:Use Texture,ptin:_UseTexture,varname:_UseTexture,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:True|A-2629-OUT,B-1210-RGB;proporder:1210-2369-4155-4027-6069-2818-9289-2542-838-8756;pass:END;sub:END;*/

Shader "Custom/SunShader" {
    Properties {
        _Diffuse ("Diffuse", 2D) = "bump" {}
        _FresnellColor ("Fresnell Color", Color) = (0.9926471,0.9050605,0.7736808,1)
        _iOR ("Fresnel IOR", Range(0, 5)) = 1.709402
        _Color1 ("Color1", Color) = (1,0.5878296,0.06617647,1)
        _Color2 ("Color2", Color) = (1,0.8068966,0,1)
        _NoiseUV ("Noise Scale", Float ) = 56
        _NoiseComplexity ("Noise Complexity", Range(0, 10)) = 1
        _Seed ("Seed", Float ) = 437.5854
        _Contrast ("Contrast", Range(-10, 10)) = -2.61
        [MaterialToggle] _UseTexture ("Use Texture", Float ) = 0
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            uniform sampler2D _Diffuse; uniform float4 _Diffuse_ST;
            uniform float4 _FresnellColor;
            uniform float _iOR;
            float noise( float2 UV , fixed Iterations , float Seed ){
            float ret = 0;
            int iterations = Iterations;
            for (int i = 0; i < iterations; ++i)
            {
               float2 p = floor(UV * (i+1));
               float2 f = frac(UV * (i+1));
               f = f * f * (3.0 - 2.0 * f);
               float n = p.x + p.y * 57.0;
               float4 noise = float4(n, n + 1, n + 57.0, n + 58.0);
               noise = frac(sin(noise)*Seed);
               ret += lerp(lerp(noise.x, noise.y, f.x), lerp(noise.z, noise.w, f.x), f.y) * ( iterations / (i+1));
            }
            return ret/iterations;
            }
            
            uniform float _NoiseUV;
            uniform float4 _Color1;
            uniform float4 _Color2;
            uniform fixed _NoiseComplexity;
            uniform float _Seed;
            uniform float _Contrast;
            uniform fixed _UseTexture;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                UNITY_FOG_COORDS(3)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = mul(UNITY_MATRIX_MVP, v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
////// Lighting:
////// Emissive:
                float node_5285 = noise( (i.uv0*_NoiseUV) , _NoiseComplexity , _Seed );
                float node_4402 = pow(node_5285,_Contrast);
                float3 node_2629 = lerp(_Color1.rgb,_Color2.rgb,lerp(0,0.5,node_4402));
                float4 _Diffuse_var = tex2D(_Diffuse,TRANSFORM_TEX(i.uv0, _Diffuse));
                float3 emissive = ((pow(1.0-max(0,dot(normalDirection, viewDirection)),_iOR)*_FresnellColor.rgb)+lerp( node_2629, _Diffuse_var.rgb, _UseTexture ));
                float3 finalColor = emissive;
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    FallBack "Unlit/Texture"
    CustomEditor "ShaderForgeMaterialInspector"
}
