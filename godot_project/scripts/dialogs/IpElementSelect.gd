extends HBoxContainer

signal selected(value)

func set_data(MacAddress: String, IpAddress: String) -> void:
	%MacLabel.set("text",MacAddress)
	%IpLabel.set("text",IpAddress)

func _on_button_pressed():
	var mac   = %MacLabel.get("text")
	var ip = %IpLabel.get("text")
	var ret: Dictionary = {	"ip_address" = ip, "mac" = mac}
	emit_signal("selected", ret)

