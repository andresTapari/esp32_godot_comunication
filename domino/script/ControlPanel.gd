extends MarginContainer

# Señales:
signal control_button_fired

func _on_StepBackButton_pressed():
	emit_signal("control_button_fired","cmd_step_back")

func _on_PlayButton_toggled(button_pressed):
	if button_pressed:
		emit_signal("control_button_fired","cmd_play")
	else:
		emit_signal("control_button_fired","cmd_pause")

func _on_StopButton_pressed():
	$HBoxContainer/PlayButton.pressed = false
	emit_signal("control_button_fired","cmd_stop")

func _on_StepFowardButton_pressed():
	emit_signal("control_button_fired","cmd_step_foward")


