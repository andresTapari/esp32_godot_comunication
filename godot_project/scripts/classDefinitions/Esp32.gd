extends Node
class_name ESP32


func digitalWrite(pinNumber:int , value: bool) -> void:
	# "$|1|x|x|0|0|0"
	var strValue = "0"
	if value:
		strValue = "1"
	var message = "$" + "|1|" + str(pinNumber) + "|" + strValue + "|0|0|0"
	if UdpServer.isConnected:
		UdpServer.send_to_client(message)


func attachServo(pinNumber:int) -> void:
	# "$|2|x|0|0|0|0"
	var message = "$" + "|2|" + str(pinNumber) + "|0|0|0|0"
	if UdpServer.isConnected:
		UdpServer.send_to_client(message)

#func digitalRead(pinNumber:int) -> bool:
#	return true
