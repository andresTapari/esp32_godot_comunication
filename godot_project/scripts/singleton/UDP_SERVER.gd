extends Node
class_name ClientNode

var udp: PacketPeerUDP = PacketPeerUDP.new()

var isConnected: bool    = false


func _process(delta):
	if udp.get_available_packet_count() > 0:
		var income_message: String = udp.get_packet().get_string_from_utf8()
#		print(income_message)
		# Si no hay coneccion evaluamos el HANDSHAKE
		if not isConnected:
			if income_message == "HANDSHAKE_RESPONSE":
				confirm_handshake()
			if income_message == "HANDSHAKE_CONFIRMED":
				isConnected = true

		# Si establecimos conexión, aqui se procesan todos los paquetes de entrada
		if isConnected:
			pass


# Conectamos con el servidor en la direccion ip y el puerto
func connect_to_client(ip_address: String, port: int ) -> void:
	var err = udp.connect_to_host(ip_address,port)
	if err == OK:
		send_handshake()
		pass

# Envia una señal de handshake a la esp32 para comprobar la coneccion
func send_handshake() -> void:
	var message: String = "HANDSHAKE_REQUEST"
	udp.put_packet(message.to_utf8_buffer())

# Envia una confimación de handshake a la esp32
func confirm_handshake() -> void:
	var message: String = "HANDSHAKE_CONFIRMED"
	udp.put_packet(message.to_utf8_buffer())
