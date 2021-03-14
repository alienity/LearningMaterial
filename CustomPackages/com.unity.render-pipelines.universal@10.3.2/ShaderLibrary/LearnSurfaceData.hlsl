#ifndef LEARN_SURFACE_DATA_INCLUDED
#define LEARN_SURFACE_DATA_INCLUDED

struct LearnSurfaceData
{
	float4 baseColor;           // default: float4(1.0)
	float4 emissive;            // default: float4(0.0, 0.0, 0.0, 1.0)
	float4 postLightingColor;   // default: float4(0.0)

	// no other field is available with the unlit shading model
    float  roughness;           // default: 1.0
    float  metallic;            // default: 0.0, not available with cloth or specularGlossiness
    float  reflectance;         // default: 0.5, not available with cloth or specularGlossiness
    float  ambientOcclusion;    // default: 0.0

    // // not available when the shading model is subsurface or cloth
    // float3 sheenColor;          // default: float3(0.0)
    // float  sheenRoughness;      // default: 0.0
    // float  clearCoat;           // default: 1.0
    // float  clearCoatRoughness;  // default: 0.0
    // float3 clearCoatNormal;     // default: float3(0.0, 0.0, 1.0)
    // float  anisotropy;          // default: 0.0
    // float3 anisotropyDirection; // default: float3(1.0, 0.0, 0.0)

    // // only available when the shading model is subsurface or refraction is enabled
    // float  thickness;           // default: 0.5

    // // only available when the shading model is subsurface
    // float  subsurfacePower;     // default: 12.234
    // float3 subsurfaceColor;     // default: float3(1.0)

    // // only available when the shading model is cloth
    // float3 sheenColor;          // default: sqrt(baseColor)
    // float3 subsurfaceColor;     // default: float3(0.0)

    // // only available when the shading model is specularGlossiness
    // float3 specularColor;       // default: float3(0.0)
    // float  glossiness;          // default: 0.0

    // not available when the shading model is unlit
    // must be set before calling prepareMaterial()
    float3 normalTS;              // default: float3(0.0, 0.0, 1.0)

    // // only available when refraction is enabled
    // float transmission;         // default: 1.0
    // float3 absorption;          // default float3(0.0, 0.0, 0.0)
    // float ior;                  // default: 1.5
    // float microThickness;       // default: 0.0, not available with refractionType "solid"
};

#endif
