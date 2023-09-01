extends MarginContainer

onready var ICON = preload('res://scenes/ui_control/pickable_item.tscn')
onready var PLACEHOLDER = preload("res://scenes/ui_control/PlaceHoder_item.tscn")
onready var ESP32SETUPDIALOG = preload("res://scenes/ui_control/conectionSetupDialog.tscn")

onready var programList := $HBoxContainer/ScrollContainer/HBoxContainer

func _ready() -> void:
	for element in programList.get_children():
		element.connect("itemListAdded",self,"checkUpdate")

func checkUpdate() -> void:
	var cmdList: Array = []
	var emptyValue: int = 0
	for element in programList.get_children():
		cmdList.append(element.cmd)
		if element.cmd.empty():
			emptyValue += 1
	if emptyValue < 1:
		var newPlaceHolder = PLACEHOLDER.instance()
		newPlaceHolder.connect("itemListAdded",self,"checkUpdate")
		programList.add_child(newPlaceHolder)
		
	print(cmdList)


func _on_HBoxContainer_child_entered_tree(node):
	print($HBoxContainer/ScrollContainer.scroll_horizontal)

func _on_CleanButton_pressed():
	for element in programList.get_children():
		if element.cmd.empty():
			element.queue_free()
	var newPlaceHolder = PLACEHOLDER.instance()
	newPlaceHolder.connect("itemListAdded",self,"checkUpdate")
	programList.add_child(newPlaceHolder)

func _on_DeleteButton_pressed():
	for element in programList.get_children():
		element.queue_free()
	var newPlaceHolder = PLACEHOLDER.instance()
	newPlaceHolder.connect("itemListAdded",self,"checkUpdate")
	programList.add_child(newPlaceHolder)


func _on_SetupButton_pressed():
	var newDialog = ESP32SETUPDIALOG.instance()
	get_parent().add_child(newDialog)
	newDialog.popup_centered()
