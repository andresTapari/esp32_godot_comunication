extends CanvasLayer

@onready var esp32 = ESP32.new()

# Señales:
func _on_reset_right_slider_pressed():
	%HSliderSpeedRight.set("value",0)

func _on_reset_left_slider_pressed():
	%HSliderSpeedLeft.set("value",0)

func _on_h_slider_speed_right_value_changed(value):
	%ResetRightSlider.set("text",str(value) + "%")
	var invertir: bool = %CheckBoxInvertRightMotor.get("button_pressed")
	esp32.servoWrite(value,0,invertir)
	
func _on_h_slider_speed_left_value_changed(value):
	%ResetLeftSlider.set("text",str(value) + "%")
	var invertir: bool= %CheckBoxInvertLeftMotor.get("button_pressed")
	esp32.servoWrite(value,1,invertir)

func _on_attach_servo_pin_btn_pressed():
	var servoRightPin = %SpinBoxPinRightMotor.get("value")
	var servoLeftPin  = %SpinBoxPinLeftMotor.get("value")
	esp32.attachServo(servoRightPin,0)
	esp32.attachServo(servoLeftPin, 1)
