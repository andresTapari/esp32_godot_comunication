extends Node
class_name ESP32


func digitalWrite(pinNumber:int , value: bool) -> void:
	# "$|1|pinNumber|value|0|0|0"
	var strValue = "0"
	if value:
		strValue = "1"
	var message = "$" + "|1|" + str(pinNumber) + "|" + strValue + "|0|0|0"
	if UdpServer.isConnected:
		UdpServer.send_to_client(message)

func attachServo(pinNumber:int, servoNumber: int) -> void:
	# "$|2|pinNumber|servoNumber|0|0|0"
	var message = "$" + "|2|" + str(pinNumber) + "|" + str(servoNumber) + "|0|0|0"
	print(message)
	if UdpServer.isConnected:
		UdpServer.send_to_client(message)

func servoWrite(angle_in_degrees: int, servoNumber: int, foward: bool = true ) -> void:
	# "$|3|angle_in_degrees|servoNumber|foward|0|0"
	var direction: int = (foward == true)
	var message = "$" + "|3|" + str(angle_in_degrees) + "|" + str(servoNumber) \
				+ "|"+str(direction) +"|0|0"
#	print(message)
	if UdpServer.isConnected:
		UdpServer.send_to_client(message)
