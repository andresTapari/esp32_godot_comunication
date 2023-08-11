#include <WiFi.h>
#include <WiFiUdp.h>
#include "definitions.h"

WiFiUDP udp;
/*
  const char* ssid = "Fibertel WiFi190 2.4GHz";       // Reemplaza con tu SSID de red WiFi
  const char* password = "0043616130";                // Reemplaza con tu contraseña de red WiFi
  const int udpPort = 12000;
*/

void setup()
{
  WiFi.begin(ssid, password);
  Serial.begin(115200);
  Serial.print("Conectando a WiFi ");
  while (WiFi.status() != WL_CONNECTED)
  {
    Serial.print(".");
    delay(1000);
  }
  Serial.println("\nConexión WiFi establecida");
  Serial.print("Dirección IP: ");
  Serial.println(WiFi.localIP());
  Serial.print("ESP Board MAC Address:  ");
  Serial.println(WiFi.macAddress());
  udp.begin(udpPort); 
  
  pinMode(13,OUTPUT);
  digitalWrite(13,LOW);
}

void loop()
{
  int packetSize = udp.parsePacket();
  if (packetSize)
  {
    char packetData[255] = "";
    int bytesRead = udp.read(packetData, sizeof(packetData));
    if (bytesRead > 0)
    {
      // Si es una solicitud de HANDSHAKE
      if (strcmp(packetData,"HANDSHAKE_REQUEST") == 0)
      {
        udp_send_data("HANDSHAKE_RESPONSE");
      }
      // Confirmacion de HANDSHAKE
      if (strcmp(packetData,"HANDSHAKE_CONFIRMED") == 0)
      {
        udp_send_data("HANDSHAKE_CONFIRMED");
        digitalWrite(13 ,HIGH);
      }
      // Si es una solicitud de PING contesta PONG
      if (strcmp(packetData,"PING") == 0)
      {
        udp_send_data("PONG");
      }
      // Mostrar los datos del paquete en el monitor serie
      Serial.print("Datos del paquete: ");
      Serial.println(packetData);
      
    }
  }
}

void udp_send_data(char *_message)
{
  udp.beginPacket(udp.remoteIP(), udp.remotePort());
  char *message = _message;
  udp.write((uint8_t *)message, strlen(message));
  udp.endPacket();
  udp.flush();
}