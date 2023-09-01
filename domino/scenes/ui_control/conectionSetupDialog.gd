extends WindowDialog

func _ready() -> void:
	_on_TimeoutHandshakeTry_timeout()

func _on_TimeoutHandshakeTry_timeout():
	if UdpServer.isConnected:
		$"%LabelStatus".set("text","Conectado")
		$"%LabelStatus".set("modulate",Color.green)
	else:
		$"%LabelStatus".set("text","Desconectado")
		$"%LabelStatus".set("modulate",Color.red)

func _on_Button_conectar_pressed():
	var ip_address: String = $"%LineEditIp".get("text")
	var port: int = $"%SpinBox".get("value")
	UdpServer.connect_to_client(ip_address, port)
	$"%LabelStatus".set("text","Estableciendo conexión")
	$"%LabelStatus".set("modulate",Color.yellow)
	$"%TimeoutHandshakeTry".start()

func _on_Button_volver_pressed():
	queue_free()

func _on_Button_ping_pressed():
	var esp32 = ESP32.new()
	esp32.digitalWrite(18, true)
	yield(get_tree().create_timer(1.0), "timeout")
	esp32.digitalWrite(18, false)
