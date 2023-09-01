extends Node
class_name ClientNode

var udp: PacketPeerUDP = PacketPeerUDP.new()
var testConectionTimer: Timer = Timer.new()
var conectionTimeOut: Timer = Timer.new()
var isConnected: bool    = false

var current_ip
var current_port

func _ready():
	testConectionTimer.set("wait_time",1)
	testConectionTimer.set("one_shot",true)
	conectionTimeOut.set("wait_time",5)
	conectionTimeOut.set("one_shot",true)
	testConectionTimer.connect('timeout',self,"_testConectionTimer_timeOut")
	conectionTimeOut.connect('timeout',self,"_conectionTimeOut_timeOut")
	add_child(testConectionTimer)
	add_child(conectionTimeOut)

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
				testConectionTimer.start()
		# Si establecimos conexión, aqui se procesan todos los paquetes de entrada
		if isConnected:
			if income_message == "PONG":
				# Si contesta pong reseteamos timer
				testConectionTimer.start()
				conectionTimeOut.stop()


# Conectamos con el servidor en la direccion ip y el puerto
func connect_to_client(ip_address: String, port: int ) -> void:
	var err = udp.connect_to_host(ip_address,port)
	if err == OK:
		send_handshake()
		pass

func send_to_client(newMessage: String) -> void:
	if isConnected:
		udp.put_packet(newMessage.to_utf8())

# Envia una señal de handshake a la esp32 para comprobar la coneccion
func send_handshake() -> void:
	var message: String = "HANDSHAKE_REQUEST"
	udp.put_packet(message.to_utf8())

# Envia una confimación de handshake a la esp32
func confirm_handshake() -> void:
	var message: String = "HANDSHAKE_CONFIRMED"
	udp.put_packet(message.to_utf8())

#Señales:
func _testConectionTimer_timeOut() -> void:
	var message: String = "PING"
	udp.put_packet(message.to_utf8())
	conectionTimeOut.start()

func _conectionTimeOut_timeOut() -> void:
	testConectionTimer.stop()
	isConnected = false
	print_debug("Error ESP32 desconectada")
