extends Node2D

# Nodos:
onready var timer   := $Timer
onready var player  := $KinematicBody2D
onready var control := $MainLvl/ControlDialog
onready var program := $MainLvl/Control/HBoxContainer/ScrollContainer/HBoxContainer

onready var esp32 = ESP32.new()	#<- Esp32

# Variables:
var cmdList : Array = []
var cmdIndx : int = 0

var startPosition : Vector2 = Vector2.ZERO
var startRotation : float = 0

export var transitionTime: float = 0.2
export var waitTime: float = 2.0
# Funciones:

func _ready():
	timer.wait_time = waitTime
	control.connect("control_button_fired", self ,"_handle_control_button_fired")
	startPosition = player.position
	startRotation = player.rotation_degrees
	add_child(esp32)

func _handle_control_button_fired(cmd: String) -> void:
	match cmd:
		"cmd_step_back":
			# Boton Volver:
			print("cmd_step_back")
			
		"cmd_play":
			# Boton Play:
			timer.start()
			print("cmd_play")

		"cmd_pause":
			timer.stop()
			print("cmd_pause")

		"cmd_stop":
			timer.stop()
			cmdIndx = 0
			player.position = startPosition
			player.rotation_degrees = startRotation
			print("cmd_stop")

		"cmd_step_foward":
			# Boton Adelantar:
			_on_Timer_timeout()
			print("cmd_step_foward")


func get_cmd_list() -> Array:
	var newCmdList: Array = []
	for element in program.get_children():
		newCmdList.append(element.cmd)
	newCmdList = delete_empty_value(newCmdList)
	return newCmdList

func delete_empty_value(list) -> Array:
	for element in list:
		if element == "":
			list.erase(element)
	return list

func _on_Timer_timeout():
	cmdList = delete_empty_value(get_cmd_list())
	if cmdIndx < cmdList.size():
		var cmd = cmdList[cmdIndx]
		esp32.handle_cmd(cmd)
		match cmd:
			"foward":
				var newPosition: Vector2 = Vector2.ZERO
				newPosition.x = player.position.x + 64*cos(deg2rad(player.rotation_degrees))
				newPosition.y = player.position.y + 64*sin(deg2rad(player.rotation_degrees))
				if !player.rayCast.get_collider():
					var tween = get_node("Tween")
					tween.interpolate_property(player, "position",player.position, 
					newPosition, transitionTime, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
					player.rayCast.force_raycast_update()
					tween.start()
			"turn_right_90":
				var tween = get_node("Tween")
				tween.interpolate_property(player, "rotation_degrees",player.rotation_degrees, 
				player.rotation_degrees + 90, transitionTime, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
				tween.start()
			"turn_left_90":
				var tween = get_node("Tween")
				tween.interpolate_property(player, "rotation_degrees",player.rotation_degrees, 
				player.rotation_degrees - 90, transitionTime, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
				tween.start()
			"turn_right_180":
				var tween = get_node("Tween")
				tween.interpolate_property(player, "rotation_degrees",player.rotation_degrees, 
				player.rotation_degrees + 180, transitionTime, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
				tween.start()

			"turn_left_180":
				var tween = get_node("Tween")
				tween.interpolate_property(player, "rotation_degrees",player.rotation_degrees, 
				player.rotation_degrees - 180, transitionTime, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
				tween.start()
			"wait":
				pass
		cmdIndx += 1
