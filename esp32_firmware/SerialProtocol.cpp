#include "SerialProtocol.h"


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
    default:  // cmd uknown
    break;
  }
  
}

void doCMD01(int *args[6])
{ 
  pinMode(*args[1], OUTPUT);
  digitalWrite(*args[1],*args[2]);
}
