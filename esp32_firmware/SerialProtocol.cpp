#include "SerialProtocol.h"

Servo servoRight; //Motor Izquierdo
Servo servoLeft;  //Motor Derecho

/**
 * @brief Decodifica un comando en formato de cadena y lo convierte en un arreglo de enteros.
 * 
 * @param command Cadena de texto que contiene el comando a decodificar.
 * @param input Arreglo de enteros donde se almacenarán los valores decodificados.
 */
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

/**
 * @brief Procesa la entrada de comandos y realiza acciones según el tipo de comando recibido.
 * 
 * @param args Arreglo de enteros que contiene los argumentos del comando recibido.
 */
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

/**
 * @brief Realiza la acción correspondiente al comando CMD1.
 * 
 * @param args Arreglo de enteros que contiene los argumentos del comando.
 */
void doCMD01(int args[6])
{ 
  pinMode(args[1], OUTPUT);
  digitalWrite(args[1],args[2]);
}

/**
 * @brief Realiza la acción correspondiente al comando CMD2.
 * 
 * @param args Arreglo de enteros que contiene los argumentos del comando.
 */
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

/**
 * @brief Realiza la acción correspondiente al comando CMD3.
 * 
 * @param args Arreglo de enteros que contiene los argumentos del comando.
 */
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

/**
 * @brief Realiza una función de mapeo personalizada entre dos rangos.
 * 
 * @param value Valor a ser mapeado.
 * @param in_min Valor mínimo del rango de entrada.
 * @param in_max Valor máximo del rango de entrada.
 * @param out_min Valor mínimo del rango de salida.
 * @param out_max Valor máximo del rango de salida.
 * @return Valor mapeado en el rango de salida.
 */
double customMap(double value, double in_min, double in_max, double out_min, double out_max) 
{
    return (value - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}