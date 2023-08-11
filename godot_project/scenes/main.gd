extends Node
#class_name ClientNode

var udp: PacketPeerUDP = PacketPeerUDP.new()


var isConnected: bool    = false

func _ready():
	# Conectamos con el host
	udp.connect_to_host("172.16.2.242",12000)
#	udp.connect_to_host("192.168.0.232", 12000)

func _process(delta):
	if udp.get_available_packet_count() > 0:
		print("Connected: %s" % udp.get_packet().get_string_from_utf8())
		isConnected = true

func _input(event):
	if Input.is_action_pressed("ui_accept"):
		var message = "Mensaje desde Godot"
		udp.put_packet(message.to_utf8_buffer())
		print("Mensaje enviado: ", message)
