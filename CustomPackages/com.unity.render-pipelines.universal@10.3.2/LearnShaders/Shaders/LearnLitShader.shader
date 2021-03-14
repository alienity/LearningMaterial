Shader "CustomShader/LearnLitShader"
{
	Properties
	{
		_BaseColor("BaseColor", Color) = (1,1,1,1)
		_Metallic("Metallic", Range(0,1)) = 0
		_Roughness("Roughness", Range(0,1)) = 0.5
		_Reflectance("Reflectance", Range(0,1)) = 0.35
		_SheenColor("SheenColor", Color) = (1,1,1,1)
		_SheenRoughness("SheenRoughness", Range(0,1)) = 0.5
		_ClearCoat("ClearCoat", Range(0,1)) = 0
		_ClearCoatRoughness("ClearCoatRoughness", Range(0,1)) = 0
		_Anisotropy("Anisotropy", Range(-1,1)) = 0
		_AnisotropyDirection("AnisotropyDirection", Vector) = (1,1,1,1)
		_AmbientOcclusion("AmbientOcclusion", Range(0,1)) = 0
		_Normal("Normal", Vector) = (1,1,1,1)
		_BentNormal("BentNormal", Vector) = (1,1,1,1)
		_ClearCoatNormal("ClearCoatNormal", Vector) = (1,1,1,1)
		_Emissive("Emissive", Vector) = (10,10,10,0.5)
		_PostLightingColor("PostLightingColor", Color) = (0.5,0.5,0.5,0.5)
		_Ior("Ior", Float) = 2
		_Transmission("Transmission", Range(0,1)) = 0.5
		_Absorption("Absorption", Vector) = (0.5,0.5,0.5,0.5)
		_MicroThickness("MicroThickness", Float) = 2
		_Thickness("Thickness", Float) = 2

        // Blending state
        [HideInInspector] _Surface("__surface", Float) = 0.0
        [HideInInspector] _Blend("__blend", Float) = 0.0
        [HideInInspector] _AlphaClip("__clip", Float) = 0.0
        [HideInInspector] _SrcBlend("__src", Float) = 1.0
        [HideInInspector] _DstBlend("__dst", Float) = 0.0
        [HideInInspector] _ZWrite("__zw", Float) = 1.0
        [HideInInspector] _Cull("__cull", Float) = 2.0
	}
	
    SubShader
	{
		Tags{"RenderType" = "Opaque" "RenderPipeline" = "UniversalPipeline" "UniversalMaterialType" = "Lit" "IgnoreProjector" = "True" "ShaderModel" = "4.5"}
		LOD 300

		Pass
		{
			Name "CustomForwardLit"
			Tags{"LightMode" = "UniversalForward"}

			Blend[_SrcBlend][_DstBlend]
			ZWrite[_ZWrite]
			Cull[_Cull]

            HLSLPROGRAM
            #pragma exclude_renderers gles gles3 glcore
            #pragma target 4.5

            // -------------------------------------
            // Material Keywords
            #pragma shader_feature_local _NORMALMAP
            #pragma shader_feature_local_fragment _ALPHATEST_ON
            #pragma shader_feature_local_fragment _ALPHAPREMULTIPLY_ON
            #pragma shader_feature_local_fragment _EMISSION
            #pragma shader_feature_local_fragment _METALLICSPECGLOSSMAP
            #pragma shader_feature_local_fragment _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A
            #pragma shader_feature_local_fragment _OCCLUSIONMAP
            #pragma shader_feature_local _PARALLAXMAP
            #pragma shader_feature_local _ _DETAIL_MULX2 _DETAIL_SCALED
            #pragma shader_feature_local_fragment _SPECULARHIGHLIGHTS_OFF
            #pragma shader_feature_local_fragment _ENVIRONMENTREFLECTIONS_OFF
            #pragma shader_feature_local_fragment _SPECULAR_SETUP
            #pragma shader_feature_local _RECEIVE_SHADOWS_OFF

            // -------------------------------------
            // Universal Pipeline keywords
            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS
            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS_CASCADE
            #pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
            #pragma multi_compile_fragment _ _ADDITIONAL_LIGHT_SHADOWS
            #pragma multi_compile_fragment _ _SHADOWS_SOFT
            #pragma multi_compile_fragment _ _SCREEN_SPACE_OCCLUSION
            #pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
            #pragma multi_compile _ SHADOWS_SHADOWMASK

            // -------------------------------------
            // Unity defined keywords
            #pragma multi_compile _ DIRLIGHTMAP_COMBINED
            #pragma multi_compile _ LIGHTMAP_ON
            #pragma multi_compile_fog

            //--------------------------------------
            // GPU Instancing
            #pragma multi_compile_instancing
            #pragma multi_compile _ DOTS_INSTANCING_ON

            #pragma vertex LitPassVertex
            #pragma fragment LitPassFragment

			#include "Packages/com.unity.render-pipelines.universal/LearnShaders/Shaders/LearnLitInput.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/LearnShaders/Shaders/LearnLitForwardPass.hlsl"
            ENDHLSL
		}

        Pass
        {
            Name "ShadowCaster"
            Tags{"LightMode" = "ShadowCaster"}

            ZWrite On
            ZTest LEqual
            ColorMask 0
            Cull[_Cull]

            HLSLPROGRAM
            #pragma exclude_renderers gles gles3 glcore
            #pragma target 4.5

            // -------------------------------------
            // Material Keywords
            #pragma shader_feature_local_fragment _ALPHATEST_ON
            #pragma shader_feature_local_fragment _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A

            //--------------------------------------
            // GPU Instancing
            #pragma multi_compile_instancing
            #pragma multi_compile _ DOTS_INSTANCING_ON

            #pragma vertex ShadowPassVertex
            #pragma fragment ShadowPassFragment

            #include "Packages/com.unity.render-pipelines.universal/Shaders/LitInput.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Shaders/ShadowCasterPass.hlsl"
            ENDHLSL
        }

        Pass
        {
            Name "DepthOnly"
            Tags{"LightMode" = "DepthOnly"}

            ZWrite On
            ColorMask 0
            Cull[_Cull]

            HLSLPROGRAM
            #pragma exclude_renderers gles gles3 glcore
            #pragma target 4.5

            #pragma vertex DepthOnlyVertex
            #pragma fragment DepthOnlyFragment

            // -------------------------------------
            // Material Keywords
            #pragma shader_feature_local_fragment _ALPHATEST_ON
            #pragma shader_feature_local_fragment _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A

            //--------------------------------------
            // GPU Instancing
            #pragma multi_compile_instancing
            #pragma multi_compile _ DOTS_INSTANCING_ON

            #include "Packages/com.unity.render-pipelines.universal/Shaders/LitInput.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Shaders/DepthOnlyPass.hlsl"
            ENDHLSL
        }

	}
}
