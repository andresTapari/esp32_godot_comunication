extends MarginContainer

onready var ICON = preload('res://scenes/ui_control/pickable_item.tscn')

func _on_Button_Foward_pressed() -> void:
	var newIcon = ICON.instance()
	newIcon.cmd = "foward"
	newIcon.normal_texture = $VBoxContainer/Button_Foward.texture_normal
	newIcon.hover_texture = $VBoxContainer/Button_Foward.texture_hover
	newIcon.texture = $VBoxContainer/Button_Foward.texture_normal
	get_parent().add_child(newIcon)

func _on_Button_Right_90_pressed() -> void:
	var newIcon = ICON.instance()
	newIcon.cmd = "turn_right_90"
	newIcon.normal_texture = $VBoxContainer/Button_Right_90.texture_normal
	newIcon.hover_texture = $VBoxContainer/Button_Right_90.texture_hover
	newIcon.texture = $VBoxContainer/Button_Right_90.texture_normal
	get_parent().add_child(newIcon)

func _on_Button_Left_90_pressed() -> void:
	var newIcon = ICON.instance()
	newIcon.cmd = "turn_left_90"
	newIcon.normal_texture = $VBoxContainer/Button_Left_90.texture_normal
	newIcon.hover_texture = $VBoxContainer/Button_Left_90.texture_hover
	newIcon.texture = $VBoxContainer/Button_Left_90.texture_normal
	get_parent().add_child(newIcon)

func _on_Button_Left_180_pressed() -> void:
	var newIcon = ICON.instance()
	newIcon.cmd = "turn_left_180"
	newIcon.normal_texture = $VBoxContainer/Button_Left_180.texture_normal
	newIcon.hover_texture = $VBoxContainer/Button_Left_180.texture_hover
	newIcon.texture = $VBoxContainer/Button_Left_180.texture_normal
	get_parent().add_child(newIcon)

func _on_Button_Right_180_pressed() -> void:
	var newIcon = ICON.instance()
	newIcon.cmd = "turn_right_180"
	newIcon.normal_texture = $VBoxContainer/Button_Right_180.texture_normal
	newIcon.hover_texture = $VBoxContainer/Button_Right_180.texture_hover
	newIcon.texture = $VBoxContainer/Button_Right_180.texture_normal
	get_parent().add_child(newIcon)

func _on_Button_Wait_pressed() -> void:
	var newIcon = ICON.instance()
	newIcon.cmd = "wait"
	newIcon.normal_texture = $VBoxContainer/Button_Wait.texture_normal
	newIcon.hover_texture = $VBoxContainer/Button_Wait.texture_hover
	newIcon.texture = $VBoxContainer/Button_Wait.texture_normal
	get_parent().add_child(newIcon)
