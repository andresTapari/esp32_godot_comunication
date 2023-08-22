extends CanvasLayer

@onready var esp32 = ESP32.new()

# Esta función se ejecuta cuando se presiona el boton encender led
func _on_button_encender_pressed():
	esp32.digitalWrite(%SpinBoxPinNumber.get("value"),true)

# Esta función se ejecuta cuando se presiona el boton apagar led
func _on_button_apagar_pressed():
	esp32.digitalWrite(%SpinBoxPinNumber.get("value"),false)
