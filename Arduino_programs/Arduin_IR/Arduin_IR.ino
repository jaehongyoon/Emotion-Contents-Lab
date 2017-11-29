#define ON 1
#define OFF 0

long previousMillis = 0;
unsigned long currentMillis = 0;

byte Command_Code[24][4] = {
{0x07, 0x07, 0x02, 0xFD}, //0x00 : 전원 0
{0x07, 0x07, 0x01, 0xFE}, //0x01 : 외부입력1
{0x07, 0x07, 0x11, 0xEE}, //0x02 : 0 2
{0x07, 0x07, 0x04, 0xFB}, //0x03 : 1 3
{0x07, 0x07, 0x05, 0xFA}, //0x04 : 2 4
{0x07, 0x07, 0x06, 0xF9}, //0x05 : 3 5
{0x07, 0x07, 0x08, 0xF7}, //0x06 : 4 6
{0x07, 0x07, 0x09, 0xF6}, //0x07 : 5 7
{0x07, 0x07, 0x0A, 0xF5}, //0x08 : 6 8
{0x07, 0x07, 0x0C, 0xF3}, //0x09 : 7 9
{0x07, 0x07, 0x0D, 0xF2}, //0x0A : 8 10
{0x07, 0x07, 0x0E, 0xF1}, //0x0B : 9 11
{0x07, 0x07, 0x1F, 0xE0}, //0x0C : 화면표시 12
{0x07, 0x07, 0x27, 0xD8}, //0x0D : TV/유선 13
{0x07, 0x07, 0x00, 0xFF}, //0x0E : 음성다중 14
{0x07, 0x07, 0x3E, 0xC1}, //0x0F : 회면크기 15
{0x07, 0x07, 0x23, 0xDC}, //0x10 : +100 16
{0x07, 0x07, 0x13, 0xEC}, //0x11 : 앞채널 17
{0x07, 0x07, 0x12, 0xED}, //0x12 : 채널 위로 18
{0x07, 0x07, 0x10, 0xEF}, //0x13 : 채널 아래로 19
{0x07, 0x07, 0x07, 0xF8}, //0x14 : 음량 크게 20
{0x07, 0x07, 0x0B, 0xF4}, //0x15 : 음량 작게 21
{0x07, 0x07, 0x1A, 0xE5}, //0x16 : 메뉴 22 
{0x07, 0x07, 0x0F, 0xF0}, //0x17 : 조용히 23
};
int command = 0;
//-----------------------------------------------------------------
// IR ON, OFF
//-----------------------------------------------------------------
void IR(boolean flag) {
if(flag) {
TCCR2A = 0b00100011; // Just enable output on Pin 3 and disable it on Pin 11
}
else {
TCCR2A = 0b00000011; // Just enable output on Pin 3 and disable it on Pin 11
}
}

void Lead_CODE(void) {
IR(ON); delayMicroseconds(4500);
IR(OFF); delayMicroseconds(4500);
}


void Bit_CODE(boolean flag) {
if(flag) {
IR(ON); delayMicroseconds(560);
IR(OFF); delayMicroseconds(1690);
}
else {
IR(ON); delayMicroseconds(560);
IR(OFF); delayMicroseconds(565);
}
}

void Code_Generator(byte value) {
int i, j;
Lead_CODE();
for(i=0;i<4;i++) {
for(j=0;j<8;j++) {
Bit_CODE((Command_Code[value][i] >> j)& 0x01);
}
}
Bit_CODE(1);
}

void setup(){
pinMode(3, OUTPUT);
TCCR2A = 0b00000011; // Just enable output on Pin 3 and disable it on Pin 11
TCCR2B = 0b00001010; // select a prescale value of 8:1 of the system clock
OCR2A = 52; // defines the frequency 51 = 38.4 KHz, 54 = 36.2 KHz, 58 = 34 KHz, 62 = 32 KHz
OCR2B = 26; // deines the duty cycle - Half the OCR2A value for 50%
Serial.begin(115200); // initialize serial:
}

void loop(){
if(Serial.available()>0) {
  currentMillis = millis();
  
  if(currentMillis - previousMillis < 500) {
    
byte inputData = (byte)Serial.read(); 

if (inputData == '0')
 command = 0;
else if (inputData == '1')
 command = 1;
 else if (inputData == '2')
 command = 2;
 else if (inputData == '3')
 command = 3;
  else if (inputData == '4')
 command = 4;
  else if (inputData == '5')
 command = 5;
  else if (inputData == '6')
 command = 6;
  else if (inputData == '7')
 command = 7;
  else if (inputData == '9')
 command = 8;
  else if (inputData == 'A')
 command = 9;
  else if (inputData == 'B')
 command = 10;
  else if (inputData == 'C')
 command = 11;
  else if (inputData == 'D')
 command = 12;
  else if (inputData == 'E')
 command = 13;
  else if (inputData == 'F')
 command = 14;
  else if (inputData == 'G')
 command = 15;
  else if (inputData == 'H')
 command = 16;
  else if (inputData == 'I')
 command = 17;
  else if (inputData == 'J')
 command = 18;
  else if (inputData == 'K')
 command = 19;
  else if (inputData == 'L')
 command = 20;
  else if (inputData == 'M')
 command = 21;
  else if (inputData == 'N')
 command = 22;
 else if (inputData == 'O')
 command = 23;
 

Code_Generator(command); 

//Code_Generator(inputData-48);

  }
}
else if(Serial.available() !=1)
{
  currentMillis =0;
}
}
