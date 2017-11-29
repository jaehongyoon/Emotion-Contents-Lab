// dllmain.cpp : DLL 응용 프로그램의 진입점을 정의합니다.
#include "stdafx.h"
#include "NeuroSky_Dll_Call.h"

NeuroSky_Dll_Call intermediate;

//Tier 1
extern "C" __declspec(dllexport) char* GetNewConnectionId();

//Tier 2
extern "C" __declspec(dllexport) char* SetDataLog();
extern "C" __declspec(dllexport) char* WriteDataLog();
extern "C" __declspec(dllexport) char* EnableBlinkDetection();
extern "C" __declspec(dllexport) char* Connect();
extern "C" __declspec(dllexport) void Disconnect();

//Tier 3
extern "C" __declspec(dllexport) char* GetValue(double* result);
extern "C" __declspec(dllexport) void FreeConnection();

char* GetNewConnection()
{
	return intermediate.GetNewConnectionId();
}

char* SetDataLog()
{
	return intermediate.SetDataLog();
}

char* WriteDataLog()
{
	return intermediate.WriteDataLog();
}

char* EnableBlinkDetection()
{
	return intermediate.EnableBlinkDetection();
}

char* Connect()
{
	return intermediate.Connect();
}

void Disconnect()
{
	intermediate.Disconnect();
}

char* GetValue(double* result)
{
	double buffer;
	buffer = intermediate.GetValue();

	result[1] = buffer;
	return "if -100000, something is wrong";
}

void FreeConnection()
{
	intermediate.FreeConnection();
}

BOOL APIENTRY DllMain( HMODULE hModule, DWORD  ul_reason_for_call, LPVOID lpReserved)
{



	switch (ul_reason_for_call)
	{
	case DLL_PROCESS_ATTACH:
	case DLL_THREAD_ATTACH:
	case DLL_THREAD_DETACH:
	case DLL_PROCESS_DETACH:
		break;
	}
	return TRUE;
}

