#ifndef SERIALPROTOCOL_H
#define SERIALPROTOCOL_H
#include <Arduino.h>

#define CMD1 1  //do_CMD01

void decodeCommand(const char *command, int *input[6]);
//void handle_comand_input(int *args);
void handle_comand_input(int *args[6]);

//Comandos:
void do_CMD01(int *args[6]);

#endif