﻿#ifndef LEARN_SURFACE_DATA_INCLUDED
#define LEARN_SURFACE_DATA_INCLUDED

struct LearnSurfaceData
{
	half3 albedo;
	half3 specular;
	half  metallic;
	half  smoothness;
	half3 normalTS;
	half3 emission;
	half  occlusion;
	half  alpha;
	half  clearCoatMask;
	half  clearCoatSmoothness;
};

#endif
