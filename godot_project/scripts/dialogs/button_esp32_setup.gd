extends Button

# Escenas
var CONNECT_CLIENT := preload("res://scenes/dialogs/ConnectClientDialog.tscn")


func _on_pressed():
	var newDialog = CONNECT_CLIENT.instantiate()
	add_child(newDialog)
