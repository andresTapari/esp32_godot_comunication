extends CanvasLayer

@onready var esp32 = ESP32.new()

# Escenas
var CONNECT_CLIENT := preload("res://scenes/dialogs/ConnectClientDialog.tscn")

# Esta funcón se ejecuta cuando se presiona setup
func _on_button_setup_pressed():
	var newDialog = CONNECT_CLIENT.instantiate()
	add_child(newDialog)

# Esta función se ejecuta cuando se presiona el boton encender led
func _on_button_encender_pressed():
	esp32.digitalWrite(13,true)

# Esta función se ejecuta cuando se presiona el boton apagar led
func _on_button_apagar_pressed():
	esp32.digitalWrite(13,false)
