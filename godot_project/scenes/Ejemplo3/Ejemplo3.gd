extends Control

@onready var esp32 = ESP32.new()


func _ready():
	esp32.attachServo(0,19)
	esp32.attachServo(0,23)

func _input(event):
	if event is InputEventJoypadMotion:
		var turn_axis: float = Input.get_axis("ui_right", "ui_left")
		var speed: float = Input.get_axis("ui_up", "ui_down")
		handle_speed_turn_axis(turn_axis,speed)
	if event is InputEventJoypadButton:
		esp32.digitalWrite(18,true)
		esp32.attachServo(19,0)
		esp32.attachServo(23,1)

func handle_speed_turn_axis(_turn_axis: float, _speed: float) -> void:
	var turnEn  = _turn_axis != 0 
	var turnDir = _turn_axis < 0
	
	var turnSpeed = map_value(abs(_turn_axis),0.0,1.0,0,100) 
	var speed = map_value(abs(_speed),0.0,1.0,0,100) 
	
	if not turnEn:
		esp32.servoWrite(speed,0,_speed > 0)
		esp32.servoWrite(speed,1,_speed < 0)
	else:
		esp32.servoWrite(turnSpeed,0,turnDir)
		esp32.servoWrite(turnSpeed,1,turnDir)
	
#	print("Turn En:",turnEn ," | Speed:",speed , "| TurnSpeed:", turnSpeed)

func map_value(value, from_min, from_max, to_min, to_max):
	# Asegurarse de que el valor esté dentro del rango de entrada
	value = max(from_min, min(from_max, value))
	# Calcular el porcentaje del valor en el rango de entrada
	var normalized_value = (value - from_min) / (from_max - from_min)
	# Calcular el valor mapeado en el rango de salida
	var mapped_value = to_min + normalized_value * (to_max - to_min)
	# Retornamos valor 
	return mapped_value
