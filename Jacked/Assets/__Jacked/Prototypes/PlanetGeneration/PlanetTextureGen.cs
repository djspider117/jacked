using UnityEngine;
using CoherentNoise;
using System.Collections;
using CoherentNoise.Generation.Fractal;
using System.Threading;
using System.Linq;
using System.Collections.Generic;
using CoherentNoise.Generation;
using CoherentNoise.Generation.Patterns;

public class PlanetTextureGen : MonoBehaviour
{
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

    public bool ColorMapEnabled = true;

    public PlanetType PlanetType = PlanetType.Earthlike;

    [Header ("Color Mapping")]
    public Color DeepOceanColor = new Color(0.561f, 0.737f, 0.561f);
    public Color SeaColor = new Color(0.118f, 0.565f, 1.000f);
    public Color ShoreColor = new Color(0.957f, 0.643f, 0.376f);
    public Color GrassColor = new Color(0.196f, 0.804f, 0.196f);
    public Color ForestColor = new Color(0.133f, 0.545f, 0.133f);
    public Color RockColor = new Color(0.545f, 0.271f, 0.075f);
    public Color IceColor = new Color(0.9f, 0.9f, 0.9f);

    [Header ("Terrain RidgeNoise Settings")]
    public float Frequency = 1f;
    public float Exponent = 0.4f;
    public float Gain = 2f;
    public float Offset = 0.7f;
    public float Lacunarity = 0.5f;
    public int OctaveCount = 6;

    public float TurbulentFrequency = 4;
    public float TurbulentPower = 0.2f;
    public int TurbulentSeed = 2;

    [Header ("[EXPERIMENTAL] Polar Caps Settings")]
    public bool HasIceCaps = true;

    [Range(1, 2)]
    public float PolarExtent = 1.7f;
    public float PolarFrequency = 1f;
    public float PolarLacunarity = 0.5f;
    public int PolarOctaveCount = 6;
    public float PolarPersistance = 0.5f;
    public float IceCapBias = 0.5f;
    public float PolarTurbulence = 4f;
    public float PolarTurbulencePower = 0.2f;
    public int PolarTurbulenceSeed = 2;


    public bool DoUpdate;

    private void Start()
    {
        Generate();
    }

    public void Update()
    {
        if (DoUpdate)
        {
            Generate();
            DoUpdate = false;
        }
    }

    private struct ThreadArgs
    {
        public Color[] pixels;
        public int i;
        internal int memPerThread;
        internal int width;
        internal int height;
    }

    private void Generate()
    {
        var timeNow = Time.time;
        _horizontalResolution = VerticalResolution * 2;


        int numThreads = 8;

        Color[] pixels = new Color[_horizontalResolution * VerticalResolution];

        Texture2D heightMap = new Texture2D(_horizontalResolution, VerticalResolution, TextureFormat.RGB24, false);

        float uInc = 1.0f / (float)_horizontalResolution;
        float vInc = 1.0f / (float)VerticalResolution;

        int memPerThread = (_horizontalResolution * VerticalResolution) / numThreads;
        Thread[] thrs = new Thread[numThreads];
        for (int t = 0; t < numThreads; t++)
        {
            var thr = new Thread((arg) =>
            {
                switch (PlanetType)
                {
                    case PlanetType.Earthlike:
                        GenerateEarthlike(arg);
                        break;
                    case PlanetType.GasGiant:
                        GenerateGasGiant(arg);
                        break;
                    default:
                        break;
                }

            });

            thrs[t] = thr;
            ThreadArgs args = new ThreadArgs()
            {
                i = t,
                pixels = pixels,
                memPerThread = memPerThread,
                width = _horizontalResolution,
                height = VerticalResolution
            };

            thr.Start(args);
        }

        foreach (var x in thrs)
        {
            x.Join();
        }

        heightMap.SetPixels(pixels);
        heightMap.Apply();

        GetComponent<Renderer>().material.SetTexture("_DiffuseTex", heightMap);
        GetComponent<Renderer>().material.mainTexture = heightMap;

        var elapsed = Time.time - timeNow;
        Debug.Log("Generated in " + elapsed + " seconds");
    }

    private void GenerateEarthlike(object arg)
    {
        var landmassGenerator = new RidgeNoise(Seed)
        {
            Frequency = Frequency,
            Exponent = Exponent,
            Gain = Gain,
            Offset = Offset,
            Lacunarity = Lacunarity,
            OctaveCount = OctaveCount
        }.Turbulence(TurbulentFrequency, TurbulentPower, TurbulentSeed);

        var polarCapsGenerator = new Function((x, y, z) => Helpers.Saw(z / PolarExtent))
            .Turbulence(PolarTurbulence, PolarTurbulencePower, PolarTurbulenceSeed)
            .Gain(0.9f);

        var qargs = (ThreadArgs)arg;
        var i = qargs.i;
        var pxls = qargs.pixels;

        var starPos = qargs.memPerThread * i;
        for (int q = starPos; q < qargs.memPerThread + starPos; q++)
        {
            var y = q / qargs.width;
            var x = q - y * qargs.width;

            var u = (float)x / (float)qargs.width;
            var v = (float)y / (float)qargs.height;

            Color targetColor = Color.clear;

            var sphericalPos = MapUV(u, v);


            var landSample = landmassGenerator.GetValue(sphericalPos);

            if (ColorMapEnabled)
                targetColor = MapLandColor(landSample);
            else
                targetColor = new Color(landSample, landSample, landSample);

            if (HasIceCaps)
            {
                var iceCapSample = Mathf.Clamp(polarCapsGenerator.GetValue(sphericalPos), 0, 1);

                Color iceColor = new Color(iceCapSample,iceCapSample,iceCapSample);

                var a = targetColor;
                var b = iceColor;
                var one = Color.white;

                targetColor = one - (one - a) * (one - b); // screen blend mode

            }

            pxls[q] = targetColor;
        }
    }

    private void GenerateGasGiant(object arg)
    {
        var landmassGenerator = new Function((x, y, z) => Helpers.Saw(z / 1))
            .Turbulence(TurbulentFrequency, TurbulentPower, TurbulentSeed);


        var qargs = (ThreadArgs)arg;
        var i = qargs.i;
        var pxls = qargs.pixels;

        var starPos = qargs.memPerThread * i;
        for (int q = starPos; q < qargs.memPerThread + starPos; q++)
        {
            var y = q / qargs.width;
            var x = q - y * qargs.width;

            var u = (float)x / (float)qargs.width;
            var v = (float)y / (float)qargs.height;

            Color targetColor = Color.clear;

            var sphericalPos = MapUV(u, v);


            var landSample = landmassGenerator.GetValue(sphericalPos);

            if (ColorMapEnabled)
                targetColor = MapLandColor(landSample);
            else
                targetColor = new Color(landSample, landSample, landSample);

            pxls[q] = targetColor;
        }
    }


    private Color MapLandColor(float landSample)
    {
        Color landColor;
        if (landSample < DeepOceanLevel)
            landColor = DeepOceanColor;
        else
                if (landSample < SeaLevel)
            landColor = InterpolateColor(DeepOceanLevel, SeaLevel, landSample, DeepOceanColor, SeaColor);
        else
                if (landSample < ShoreLevel)
            landColor = InterpolateColor(SeaLevel, ShoreLevel, landSample, SeaColor, ShoreColor);
        else
                if (landSample < GrassLevel)
            landColor = InterpolateColor(ShoreLevel, GrassLevel, landSample, ShoreColor, GrassColor);
        else
                if (landSample < ForestLevel)
            landColor = InterpolateColor(GrassLevel, ForestLevel, landSample, GrassColor, ForestColor);
        else
                if (landSample < RockLevel)
            landColor = InterpolateColor(ForestLevel, RockLevel, landSample, ForestColor, RockColor);
        else
            landColor = InterpolateColor(RockLevel, 1.0f, landSample, RockColor, IceColor);
        return landColor;
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

public enum PlanetType
{
    Earthlike,
    GasGiant
}