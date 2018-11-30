﻿
Shader "GD3/StandardDiffuse" {

	Properties {
		// color is 0-1
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
		_Amount("Extrusion Amount", Range(-1,1)) = 0
		
	}

	SubShader {

		// met 'tags' vertellen wanneer ze gerenderd moeten worden
		Tags { "RenderType"="Opaque" }
		// Shaderlab LOD -> is voor jezelf om aan te geven hoe 'zwaar' deze shader is. Kun je op filteren
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Lambert vertex:vert
		//#pragma surface surf Standard fullforwardshadows

		// Naar welke shader model compilen we?
		#pragma target 3.0

		// We moeten de properties ook declareren als variabelen. Unity koppelt ze automatisch
		fixed4 _Color; // 11bit
		sampler2D _MainTex;
		half _Glossiness; // 16 bit
		half _Metallic;
		float _Amount;

		// we maken een structuur aan met 'auto' variabelen die we nodig hebben in onze surf functie
		// beschikbare properties: https://docs.unity3d.com/Manual/SL-SurfaceShaders.html
		struct Input {
			float2 uv_MainTex; // we vragen om de uv mapping van MainText t.o.v. de vertex
		};
		
		
		void Update() {
			
		}
		void vert(inout appdata_full v) {
			v.vertex.xyz += v.normal * _Amount;
		}

		// SurfaceOutputStandard bepaald welke struct met properties er nodig zijn voor onze lightning model
		void surf (Input IN, inout SurfaceOutput o) {
			// we pakken de kleur uit de texture en vermenigvuldigen met de fixed floats
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;

			// albedo is de diffuse (eigen) kleur
			o.Albedo = c.rgb;

			//o.Metallic = _Metallic;
			//o.Smoothness = _Glossiness;
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}

// datatypes:
// er zijn single values & packed arrays (verzameling). Packed array kunnen via xyz en rgba worden benaderd