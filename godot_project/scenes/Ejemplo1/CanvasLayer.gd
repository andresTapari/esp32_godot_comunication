extends CanvasLayer

# Escenas

var CONNECT_CLIENT := preload("res://scenes/dialogs/ConnectClientDialog.tscn")

# Esta funcón se ejecuta cuando se presiona setup
func _on_button_setup_pressed():
	var newDialog = CONNECT_CLIENT.instantiate()
	add_child(newDialog)

# Esta función se ejecuta cuando se presiona el boton encender led
func _on_button_encender_pressed():
	# $|F1|PIN|VALUE
	UdpServer.send_to_client("$|1|13|1|0|0|0")
	pass # Replace with function body.

# Esta función se ejecuta cuando se presiona el boton apagar led
func _on_button_apagar_pressed():
	UdpServer.send_to_client("$|1|13|0|0|0|0")
	pass
