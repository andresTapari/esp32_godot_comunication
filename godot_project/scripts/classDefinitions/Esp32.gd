extends Node
class_name ESP32

# digitalWrite(pinNumber: int, value: bool) -> void
# Esta función permite enviar comandos para establecer el valor digital (alto o 
# bajo) de un pin específico.
#
# El comando se envía en forma de mensaje a través de un servidor UDP (User 
# Datagram Protocol) para controlar dispositivos externos o realizar acciones 
# en base a la señal de un pin.
#
# Parámetros:
# - pinNumber (int): El número del pin que se desea controlar.
# - value (bool): El valor que se quiere establecer en el pin (True para alto, False para bajo).

func digitalWrite(pinNumber:int , value: bool) -> void:
	var strValue = "0"
	if value:
		strValue = "1"
	var message = "$" + "|1|" + str(pinNumber) + "|" + strValue + "|0|0|0"
	if UdpServer.isConnected:
		# "$|1|pinNumber|value|0|0|0"
		UdpServer.send_to_client(message)

# attachServo(pinNumber: int, servoNumber: int) -> void
# Esta función permite enviar un mensaje para adjuntar un servo motor a un pin específico.
# El mensaje se envía a través de un servidor UDP (User Datagram Protocol) para configurar y controlar
# el servo motor en dispositivos externos.
#
# Parámetros:
# - pinNumber (int): El número del pin al que se desea adjuntar el servo motor.
# - servoNumber (int): El número o identificador del servo motor que se está configurando.

func attachServo(pinNumber:int, servoNumber: int) -> void:
	var message = "$" + "|2|" + str(pinNumber) + "|" + str(servoNumber) + "|0|0|0"
	if UdpServer.isConnected:
		# "$|2|pinNumber|servoNumber|0|0|0"
		UdpServer.send_to_client(message)

# servoWrite(angle_in_degrees: int, servoNumber: int, foward: bool = True) -> void
# Esta función envía un mensaje para controlar la posición de un servo motor adjunto a un pin 
# específico.
# El mensaje se envía a través de un servidor UDP (User Datagram Protocol) para 
# mover el servo a un ángulo determinado.
#
# Parámetros:
# - angle_in_degrees (int): El ángulo en grados al que se desea mover el servo motor.
# - servoNumber (int): El número o identificador del servo motor que se va a controlar.
# - foward (bool): Indica si el movimiento es hacia adelante (True) o hacia 
# atrás (False). Valor predeterminado: True.

func servoWrite(angle_in_degrees: int, servoNumber: int, foward: bool = true ) -> void:
	var direction: int = (foward == true)
	var message = "$" + "|3|" + str(angle_in_degrees) + "|" + str(servoNumber) \
				+ "|"+str(direction) +"|-1|0"
	if UdpServer.isConnected:
		# "$|3|angle_in_degrees|servoNumber|foward|0|0"
		UdpServer.send_to_client(message)
