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
  Serial.println("");
  Serial.println("Conexión WiFi establecida");
  Serial.print("Dirección IP: ");
  Serial.println(WiFi.localIP());
  udp.begin(udpPort); 
}

void loop()
{
  int packetSize = udp.parsePacket();
  if (packetSize)
  {
    char packetData[255];
    int bytesRead = udp.read(packetData, sizeof(packetData));
    if (bytesRead > 0)
    {
      // Mostrar los datos del paquete en el monitor serie
      Serial.print("Datos del paquete: ");
      Serial.println(packetData);
      
      // Procesa los datos recibidos, por ejemplo, envía una respuesta
      udp.beginPacket(udp.remoteIP(), udp.remotePort());
      char *message = "Respuesta desde ESP32";
      udp.write((uint8_t *)message, strlen(message));
      udp.endPacket();
    }
  }
}