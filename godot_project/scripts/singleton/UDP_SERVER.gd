extends Node
class_name ClientNode

var udp: PacketPeerUDP = PacketPeerUDP.new()

var isConnected: bool    = false


func _process(delta):
	if udp.get_available_packet_count() > 0:
		# Si no hay coneccion evaluamos el HANDSHAKE
		if not isConnected:
			var income_message: String = udp.get_packet().get_string_from_utf8()
			if income_message == "HANDSHAKE_RESPONSE":
				isConnected = true
		# Si establecimos conección, aqui se procesan todos los paquetes de entrada
		if isConnected:
			pass


# Conectamos con el servidor en la direccion ip y el puerto
func connect_to_client(ip_address: String, port: int ) -> void:
	udp.connect_to_host(ip_address,port)

# Envia una señal de handshake a la esp32 para comprobar la coneccion
func send_handshake() -> void:
	var message: String = "HANDSHAKE_REQUEST"
	udp.put_packet(message.to_utf8_buffer())


