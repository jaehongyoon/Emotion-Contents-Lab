// NeuroSky_Dll_Call.cpp : DLL 응용 프로그램을 위해 내보낸 함수를 정의합니다.
//

#include "stdafx.h"

#pragma once

// all required data/functions stored in the header file
#include <sstream>

#include "NeuroSky_Dll_Call.h"

// initialize private parameters

NeuroSky_Dll_Call::NeuroSky_Dll_Call(void)
{
	//initialize connection id
	connectionid = 0;
	//set to non-zero value to a newline
	//and timestamp are automatically prepended
	//to the @c msg in the Stream Log file.
	//
	insertTimestamp = 1;
	// instead of usual unsinged raw data the dll will reconstuct the raw
	// data to full raw wave value by simply shifting the first byte left 
	// by 8 bits, and second byte
	// in this case, high baud rate is desired which should be same as or 
	// above 57600. We choosed 115200 for safety issue (fastest).
	//
	serialBaudrate = 115200;
	//set to data packet
	serialDataFormat = 0;
	//set dataType to raw
	dataType = 4;

	//were using COM4 Port for NeuroSky
	serialPortName = "\\\\.\\COM40";
	//we do not require comment when wrting log
	msg = NULL;
	filename = "DataLog.txt";
}

char* NeuroSky_Dll_Call::GetNewConnectionId()
{
	//get connection id
	connectionid = TG_GetNewConnectionId();

	if(connectionid == -1)
	{
		return "ERROR: Too many connections";
	}
	else if(connectionid == -2)
	{
		return "ERROR: Out of memory";
	}
	else
	{
		//
		//stringstream convert;
		//convert << connectionid;
		//std::string RString = convert.str();
		//char* Result;
		//Result[RString.copy(Result, RString.length())] = '\0';
		//return Result;
		//
		return "Success";
	}	
}

char* NeuroSky_Dll_Call::SetDataLog()
{
	int errCode = TG_SetDataLog(connectionid, filename);
	if(errCode == -1)
	{
		return "ERROR: Invalid connection ID";
	}
	else if(errCode == -2)
	{
		return "ERROR: Invalid file name";
	}
	else
	{
		return "Success";
	}
}

char* NeuroSky_Dll_Call::WriteDataLog()
{
	int errCode = TG_WriteDataLog(connectionid, insertTimestamp, msg);
	
	if(errCode == -1)
	{
		return "ERROR: Invalid connection ID";
	}
	else if(errCode == -2)
	{
		return "ERROR: Stream log not opened yet";
	}
	else
	{
		return "Success";
	}
}


char* NeuroSky_Dll_Call::EnableBlinkDetection()
{
	int errCode = TG_EnableBlinkDetection(connectionid, 1);

	if(errCode == -1)
	{
		return "ERROR: Invalid connection ID";
	}
	else
	{
		return "Success";
	}
}

char* NeuroSky_Dll_Call::Connect()
{
	int errCode =TG_Connect(connectionid, serialPortName, 
		serialBaudrate, serialDataFormat);

	if(errCode == -1)
	{
		return "ERROR: Invalid connection ID";
	}
	else if(errCode == -2)
	{
		return "ERROR: COM Port cannot be opened";
	}
	else if(errCode == -3)
	{
		return "Invalid Baudrate";
	}
	else if(errCode == -4)
	{
		return "Invalid data format";
	}
	else
	{
		return "Success";
	}

}

void NeuroSky_Dll_Call::Disconnect()
{
	TG_Disconnect(connectionid);
}

double NeuroSky_Dll_Call::GetValue()
{

	int numPacket = 1;
	int PacketRead = TG_ReadPackets(connectionid, numPacket);
//	double result;

	if (numPacket == -1)
	{
		return -10000000;
		//return "ERROR: Invalid connection ID";
	}
	else if (numPacket == -2)
	{
		return -10000000;
		//return "ERROR: No data to read";
	}
	else if (numPacket == -3)
	{
		return -10000000;
		//return "ERROR:I/O error occurs";
	}
	else
		// case when packet number is 1
	{
		if(TG_GetValueStatus(connectionid, dataType) != 0)
		{
			float raw = TG_GetValue(connectionid, dataType);
			
			//reconstruct data into full wave value
			//unsigned char const *bytes;

			//bytes = reinterpret_cast<unsigned char *>(&raw);
			//result = bytes[0]*256 + bytes[1];
			//if (result >= 32768)
			//{
			//	result = 65536 - result;
			//}
			return raw;
		}
		else
		{
			return -10000000;
			//return "ERROR: Packet does not contain new raw wave value"; 
		}
	}
}

void NeuroSky_Dll_Call::FreeConnection()
{
	TG_FreeConnection(connectionid);
}
