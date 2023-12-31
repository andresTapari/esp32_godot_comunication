#ifndef SERIALPROTOCOL_H
#define SERIALPROTOCOL_H

#include <Arduino.h>
#include <ESP32_Servo.h>

#define CMD1 1  //doCMD01 
#define CMD2 2  //doCMD02
#define CMD3 3  //doCMD03 

void decodeCommand(const char *command, int input[6]);
void handle_comand_input(int args[6]);

// Comandos:
void doCMD01(int args[6]);
void doCMD02(int args[6]);
void doCMD03(int args[6]);

// Funciones
double customMap(double value, double in_min, double in_max, double out_min, double out_max);
void setup_interrupt_timer(int miliSecondsToWait);
void IRAM_ATTR timer_servo_run_timeOut();

#endif