extends HBoxContainer

func set_data(MacAddress: String, IpAddress: String) -> void:
	%MacLabel.set("text",MacAddress)
	%IpLabel.set("text",IpAddress)


func _on_button_pressed():
	print("Ip Selected")

