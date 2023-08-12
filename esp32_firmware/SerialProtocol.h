#ifndef SERIALPROTOCOL_H
#define SERIALPROTOCOL_H
#include <Arduino.h>

#define CMD1 1  //doCMD01

void decodeCommand(const char *command, int *input[6]);
void handle_comand_input(int *args[6]);

//Comandos:
void doCMD01(int *args[6]);

#endif