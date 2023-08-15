#include "SerialProtocol.h"

Servo servoRight; //Motor Izquierdo
Servo servoLeft;  //Motor Derecho

// Decodificar comandos
void decodeCommand(const char *command, int input[]) 
{
  char *token;
  char *rest = (char *)command;  // Copia de la cadena para no modificar la original
  int index = 0;

  // Ignoramos el primer token (inicio del comando)
  token = strtok_r(rest, "|", &rest);
  if (token != NULL && strcmp(token, "$") == 0) 
  {
    while ((token = strtok_r(rest, "|", &rest)) != NULL && index < 6) 
    {
      int value = atoi(token);
      input[index] = value;
      index++;
    }
  }
  else 
  {
    Serial.println("Comando inválido");
  }
}

void handle_comand_input(int args[6])
{
  // Serial.println("Handle_comand_input:");
  switch(args[0])
  {
    case CMD1: //do CMD 1
    {
      doCMD01(args);
      break;
    }
    case CMD2: //do CMD 1
    {
      doCMD02(args);
      break;
    }
    case CMD3: //do CMD 1
    {
      doCMD03(args);
      break;
    }  
    default:  // cmd desconocido
    break;
  }
  
}

// esp32.digitalWrite(pinNumber,value)
// establece el valor logico de value en pinNumber
void doCMD01(int args[6])
{ 
  pinMode(args[1], OUTPUT);
  digitalWrite(args[1],args[2]);
}

// esp32.servoAtach(pinNumber, right=0/left=1)
// Establece los pines del robot 
void doCMD02(int args[6])
{
  if(args[2] == 0)
  {
    servoRight.attach(args[1]);
  }
  else
  {
    servoLeft.attach(args[1]);
  }
}

// esp32.servoWrite(value, right=0/left=1)
void doCMD03(int args[6])
{
  // 90 = velocidad de reposo para servo continuo  (<- MAX = 0 --- 90 --- 180 = MAX ->)
  int speedRight = 90;  
  int speedLeft  = 90;
  // Seleccionamos numero de servo
  if( args[2] == 0)  
  {
    int topValue = 0;
    if(args[3] == 1)
    {
      topValue = 180;
    }
    speedRight = (int)customMap(args[1],0,100,90, topValue); 
    servoRight.write(speedRight);
  }
  else
  {
    int topValue = 0;
    if(args[3] == 1)
    {
      topValue = 180;
    }
    speedLeft = (int)customMap((double)args[1], 0, 100, 90, topValue); 
    servoLeft.write(speedLeft);
  }
}


double interpolate(double value, double min, double max) {
    // Asegurarse de que 'value' esté dentro del rango [min, max]
    if (value < min) value = min;
    if (value > max) value = max;
    
    // Calcular la fracción de 'value' entre 'min' y 'max'
    double fraction = (value - min) / (max - min);
    
    // Interpolación lineal entre 'min' y 'max'
    return min + fraction * (max - min);
}

double customMap(double value, double in_min, double in_max, double out_min, double out_max) 
{
    // Mapea el valor desde el rango de entrada al rango de salida
    return (value - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}