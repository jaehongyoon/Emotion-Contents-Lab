#pragma once

#include "thinkgear.h"
#include <iostream>

/* This block is standard for DLL macro definitions, and
 * typical users should ignore this block entirely.
 * Maintainers of the DLL should define THINKGEAR_DLL_COMPILE
 * when compiling the DLL.
 */

/*
 Maximum number of Connections that can be requested before being
 required to free one.
 */

#define TG_MAX_CONNECTION_HANDLES 128

/*
 Baud rate for use with TG_Connect() and TG_SetBaudrate().
 */

#define TG_BAUD_1200         1200
#define TG_BAUD_2400         2400
#define TG_BAUD_4800         4800
#define TG_BAUD_9600         9600
#define TG_BAUD_57600       57600
#define TG_BAUD_115200     115200

/*
 Data format for use with TG_Connect() and TG_SetDataFormat().
 */
#define TG_STREAM_PACKETS      0
#define TG_STREAM_5VRAW        1
#define TG_STREAM_FILE_PACKETS 2

/*
 Data types that can be requested from TG_GetValue().  Only
 certain data types are output by certain ThinkGear chips
 and headsets.  Please refer to the Communications Protocol
 document for your chip/headset to determine which data types
 are available for your hardware.
 */

#define TG_DATA_BATTERY             0
#define TG_DATA_POOR_SIGNAL         1
#define TG_DATA_ATTENTION           2
#define TG_DATA_MEDITATION          3
#define TG_DATA_RAW                 4
#define TG_DATA_DELTA               5
#define TG_DATA_THETA               6
#define TG_DATA_ALPHA1              7
#define TG_DATA_ALPHA2              8
#define TG_DATA_BETA1               9
#define TG_DATA_BETA2              10
#define TG_DATA_GAMMA1             11
#define TG_DATA_GAMMA2             12
#define TG_DATA_BLINK_STRENGTH     37

using namespace std;

/*
NeuroSky DLL has Tiers for the functions and function of
higher Tier should be called before operating lower tier
functions

Tier1:
GetNewConnectionId()

Tier2:
SetDataLog(char *filename);
WriteDataLog();
EnableBlinkDetection();
Connect();

Tier3:
GetValue(double result);
FreeConnection();
*/

class NeuroSky_Dll_Call
{

//construction
public:

	/*
	initialization
	*/
	NeuroSky_Dll_Call(void);
	
	/*
	GetNewConnectionId() = use APIs TG_NewConnectionID to achieve an ID handle (an int) to a newly-allocated ThinkGear Connection object.

	<TG_New ConnectionID return values>
	@return -1 if too many Connections have been created without being freed
	by TG_FreeConnection().
 
	@return -2 if there is not enough free memory to allocate to a new
	        ThinkGear Connection.
 
	@return The ID handle of a newly-allocated ThinkGear Connection.

	<NewConnectionaID return values>
	- corresponding messages (char array)
	@"too many connections" case when return of TG_NewConnectionID is -1.
 
	@"Out of memory" case when return of TG_NewConnectionID is -2.
 
	@ID handle of a newly-allocated ThinkGear Connection.
	*/
	char* GetNewConnectionId();

	/*
	This function enables to log the data into a log file. This function is
	called for debugging purposes. The function calls TG_SetDataLog func
	with an appropriate file path to store the log. GetNewConnectionId is
	prerequisite to call this function


	<TG_GetSetDataLog return values>
	@return -1 if @c connectionId does not refer to a valid ThinkGear
           Connection ID handle.
 
	@return -2 if @c filename could not be opened for writing.  You may
           check errno for the reason.
  
	@return 0 on success.

	<GetSetDataLog return values>
	@"invalid connection ID" case when return of TG_SetDataLog is -1

	@"invalid file name" case when return of TG_SetDataLog is -2

	@"success" case when return of TG_SetDataLog is 0
	*/
	char* SetDataLog();

	/*
	Wrties a message into the Coonections's Data Log. The program will
	write each message in a new line preceded by a timestamp. This func
	requires SetDataLog as a prerequisite.

	<TG_WriteDataLog return values>
	@return -1 if @c connectionId does not refer to a valid ThinkGear
           Connection ID handle.
 
	@return -2 if Stream Log for the @c connectionId has not been
          opened for writing via TG_SetStreamLog().
  
	@return 0 on success.

	<WriteDataLog return values>
	@"invalid connection ID" case when return of TG_WriteDataLog is -1

	@"stream log not opened yet" case when return of TG_WriteDataLog is -2

	@"Success" case when return of TG_WriteDataLog is 0
	*/
	char* WriteDataLog();

	/*
	Enables non-embedded eye blink detection. Non embedded eyeblink is 
	disables by default.

	<TG_EnableBlinkDetection return values>
	@return -1 if @c connectionId does not refer to a valid ThinkGear
           Connection ID handle.
 
 	@return 0 on Success.

	<EnableBlinkDetection return values>
	@"invalid connection ID" case when return of TG_EnableBlinkDetection is -1
	
	@"Success" case when return of TG_EnableBlinkDetection is 0
	*/
	char* EnableBlinkDetection();

	/*
	Connects the device with computer with acquired connectionid to a serial comunication
	(COM) port to communicate with a ThinkGear module.

	<TG_Connect return value>
	@return -1 if @c connectionId does not refer to a valid ThinkGear
	         Connection ID handle.
 
	@return -2 if @c serialPortName could not be opened as a serial
	         communication port for any reason.  Check that the name
	         is a valid COM port on your system.
 
	@return -3 if @c serialBaudrate is not a valid TG_BAUD_* value.
	
	@return -4 if @c serialDataFormat is not a valid TG_STREAM_* type.

	@return 0 on Success.

	<Connect return value>
	@"invalid connection ID" case when return of TG_EnableBlinkDetection is -1

	@"COM Port cannot be opened" case when return of TG_EnableBlinkDetection is -2

	@"Invalid Baudrate" case when return of TG_EnableBlinkDetection is -3

	@"Invalid data format" case when return of TG_EnableBlinkDetection is -4

	@"Success" case when return of TG_EnableBlinkDetection is 0
	*/
	char* Connect();

	/*
	This function disconnects the  ThinkGear connection for given connectionId.
	To reconnect, simply call Connect() function with same connectionId.
	*/
	void Disconnect();

	/*
	This function enables to read 1 Packet data from the serial stream by using ThinkGear
	connection. The connection internally "remember" the latest value read of each data
	type.

	Originally, the API separted the part by calling TG_ReadPacket and TG_GetValue separately
	as the data type may differ from case to case depending on the platform. However, as only
	raw data is required for our project, the GetValue() function merges both functions and only
	acquire raw data.

	I suggest to call EnableBlinkDetection() before GetValue() though it is not mandatory.

	In order to use in LabVIEW, plug in a float variable to extract the return value of
	TG_GetValue.

	<TG_ReadPacket return values>
	@return -1 if @c connectionId does not refer to a valid ThinkGear
	         Connection ID handle.
 
	@return -2 if there were not even any bytes available to be read from
	        the Connection's serial communication stream.
 
	@return -3 if an I/O error occurs attempting to read from the Connection's
	       serial communication stream.
 
	@return The number of Packets that were successfully read and parsed
	        from the Connection.

	<TG_GetValue return values>
	@return The most recent value of the requested @c dataType.

	<GetValue return value>
	@"invalid connection ID" case when return of TG_ReadPacket is -1.

	@"No data to read" case when return of TG_ReadPacket is -2.

	@"I/O error occurs" case when return of TG_ReadPacket is -3.

	@"Packet does not contain new raw wave value" case when TG_GetValueStatus returns 0 which
	means Packet does not contain new raw wave value to read.

	@"Success" when Packet Read has succeeded. In this case float @param result will give the
	latest raw data.
	*/
	double GetValue();

	/*
	Disable connection and clean up the memory. This function calls TG_FreeConnection
	which in turn calls TG_Disconnect() automatically.
	*/
	void FreeConnection();

private:

	int connectionid;
	int insertTimestamp;
	int serialBaudrate;
	int serialDataFormat;
	int dataType;

	const char *serialPortName;
	char *msg;
	const char* filename;

};