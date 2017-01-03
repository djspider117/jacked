using UnityEngine;
using CoherentNoise;
using System.Collections;
using CoherentNoise.Generation.Fractal;
using System.Threading;
using System.Linq;
using System.Collections.Generic;

public class PlanetTextureGen : MonoBehaviour
{
    private Generator _generator;
    private int _horizontalResolution;

    public int Seed;
    public int VerticalResolution = 1024;

    [Header ("Region Mapping") ]
    public float DeepOceanLevel = 0.1f;
    public float SeaLevel = 0.1f;
    public float ShoreLevel = 0.15f;
    public float GrassLevel = 0.3f;
    public float ForestLevel = 0.7f;
    public float RockLevel = 0.8f;

    [Header ("Color Mapping")]
    public Color DeepOceanColor = new Color(0.561f, 0.737f, 0.561f);
    public Color SeaColor = new Color(0.118f, 0.565f, 1.000f);
    public Color ShoreColor = new Color(0.957f, 0.643f, 0.376f);
    public Color GrassColor = new Color(0.196f, 0.804f, 0.196f);
    public Color ForestColor = new Color(0.133f, 0.545f, 0.133f);
    public Color RockColor = new Color(0.545f, 0.271f, 0.075f);
    public Color IceColor = new Color(0.9f, 0.9f, 0.9f);

    private void Start()
    {
        Generate();
    }

    private void Generate()
    {
        _horizontalResolution = VerticalResolution * 2;
        _generator = new RidgeNoise(Seed)
        {
            Frequency = 1f,
            Exponent = 0.4f,
            Gain = 2f,
            Offset = 0.7f
        }.Turbulence(4, 0.2f, 2);



        Color[] pixels = new Color[_horizontalResolution * VerticalResolution];

        Texture2D heightMap = new Texture2D(_horizontalResolution, VerticalResolution, TextureFormat.RGB24, false);

        float uInc = 1.0f / (float)_horizontalResolution;
        float vInc = 1.0f / (float)VerticalResolution;

        int mem = (_horizontalResolution * VerticalResolution);

        for (int q = 0; q < mem; q++)
        {
            var y = q / _horizontalResolution;
            var x = q - y * _horizontalResolution;

            var u = (float)x / _horizontalResolution;
            var v = (float)y / VerticalResolution;

            var noisePos = MapUV(u, v);
            var noiseSample = _generator.GetValue(noisePos);
            Color targetColor = new Color(noiseSample, noiseSample, noiseSample);

            if (noiseSample < DeepOceanLevel)
                targetColor = DeepOceanColor;
            else
               if (noiseSample < SeaLevel)
                targetColor = InterpolateColor(DeepOceanLevel, SeaLevel, noiseSample, DeepOceanColor, SeaColor);
            else
               if (noiseSample < ShoreLevel)
                targetColor = InterpolateColor(SeaLevel, ShoreLevel, noiseSample, SeaColor, ShoreColor);
            else
               if (noiseSample < GrassLevel)
                targetColor = InterpolateColor(ShoreLevel, GrassLevel, noiseSample, ShoreColor, GrassColor);
            else
               if (noiseSample < ForestLevel)
                targetColor = InterpolateColor(GrassLevel, ForestLevel, noiseSample, GrassColor, ForestColor);
            else
               if (noiseSample < RockLevel)
                targetColor = InterpolateColor(ForestLevel, RockLevel, noiseSample, ForestColor, RockColor);
            else
                targetColor = InterpolateColor(RockLevel, 1.0f, noiseSample, RockColor, IceColor);

            pixels[q] = targetColor;
        }

        heightMap.SetPixels(pixels);
        heightMap.Apply();

        GetComponent<Renderer>().material.SetTexture("_DiffuseTex", heightMap);
        GetComponent<Renderer>().material.mainTexture = heightMap;
    }

    private Color InterpolateColor(float sampleMin, float sampleMax, float sample, Color min, Color max)
    {
        var t = Mathf.InverseLerp(sampleMin, sampleMax, sample);
        return Color.Lerp(min, max, t);
    }

    private Vector3 MapUV(float u, float v)
    {
        var azimuth = 2 * Mathf.PI * u;
        var inclination = Mathf.PI * v;
        var x = Mathf.Sin(inclination) * Mathf.Cos(azimuth);
        var y = Mathf.Sin(inclination) * Mathf.Sin(azimuth);
        var z = Mathf.Cos(inclination);

        return new Vector3(x, y, z);
    }

}
