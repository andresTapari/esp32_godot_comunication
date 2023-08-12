#include "SerialProtocol.h"

Servo servoRight; //Motor Izquierdo
Servo servoLeft;  //Motor Derecho

// Decodificar comandos
void decodeCommand(const char *command, int *input[6]) 
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
      input[index] = new int(value);
      index++;
    }
  }
  else 
  {
    Serial.println("Comando inválido");
  }
}

void handle_comand_input(int *args[6])
{
  // Serial.println("Handle_comand_input:");
  switch(*args[0])
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
void doCMD01(int *args[6])
{ 
  pinMode(*args[1], OUTPUT);
  digitalWrite(*args[1],*args[2]);
}

// esp32.servoAtach(pinNumber,right=0/left=1)
// Establece los pines del robot 
void doCMD02(int *args[6])
{
  if(*args[1] == 0)
  {
    servoRight.attach(*args[1]);
  }
  else
  {
    servoLeft.attach(*args[1]);
  }
}

// esp32.robotRun(speed, direction)
void doCMD03(int *args[6])
{
  // 90 = velocidad de reposo para servo continuo
  int speedRight = 90;  
  int speedLeft  = 90;
  // Si va en una dirección
  if( *args[2] == 1)  
  {
    speedRight = (int)interpolate(*args[1],0,90);
    speedLeft  = (int)interpolate(*args[1],90,180);   // <- Un motor gira opuesto para la misma direccion
  }
  // Si va en la direccion contraria
  else
  {
    speedLeft = (int)interpolate(*args[1],0,90);
    speedRight  = (int)interpolate(*args[1],90,180);   // <- Un motor gira opuesto para la misma direccion
  }
  servoRight.write(speedRight);
  servoLeft.write(speedLeft);
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