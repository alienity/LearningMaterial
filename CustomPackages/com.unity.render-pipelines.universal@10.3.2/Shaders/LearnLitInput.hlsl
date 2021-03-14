#ifndef LEARN_LIT_INPUT_INCLUDED
#define LEARN_LIT_INPUT_INCLUDED

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/CommonMaterial.hlsl"
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LearnSurfaceInput.hlsl"
#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/ParallaxMapping.hlsl"

// NOTE: Do not ifdef the properties here as SRP batcher can not handle different layouts.
CBUFFER_START(UnityPerMaterial)
float4 _BaseColor;
float  _Metallic;
float  _Roughness;
float  _Reflectance;
float3 _SheenColor;
float  _SheenRoughness;
float  _ClearCoat;
float  _ClearCoatRoughness;
float  _Anisotropy;
float3 _AnisotropyDirection;
float  _AmbientOcclusion;
float3 _Normal;
float3 _BentNormal;
float3 _ClearCoatNormal;
float4 _Emissive;
float4 _PostLightingColor;
float  _Ior;
float  _Transmission;
float3 _Absorption;
float  _MicroThickness;
float  _Thickness;
CBUFFER_END

inline void InitializeStandardLitSurfaceData(float2 uv, out LearnSurfaceData outSurfaceData)
{
//     half4 albedoAlpha = SampleAlbedoAlpha(uv, TEXTURE2D_ARGS(_BaseMap, sampler_BaseMap));
//     outSurfaceData.alpha = Alpha(albedoAlpha.a, _BaseColor, _Cutoff);

//     half4 specGloss = SampleMetallicSpecGloss(uv, albedoAlpha.a);
//     outSurfaceData.albedo = albedoAlpha.rgb * _BaseColor.rgb;

    outSurfaceData.baseColor = _BaseColor;
    outSurfaceData.emissive = _Emissive;
    outSurfaceData.postLightingColor = _PostLightingColor;
    
    outSurfaceData.roughness = _Roughness;
    outSurfaceData.metallic = _Metallic;
    outSurfaceData.reflectance = _Reflectance;
    outSurfaceData.ambientOcclusion = _AmbientOcclusion;
    
    outSurfaceData.normalTS = float3(0,0,1);
}

#endif // UNIVERSAL_INPUT_SURFACE_PBR_INCLUDED
