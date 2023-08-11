extends Window

signal ip_selected(ip_address)

#Escenas:
@onready var IP_ELEMENT = preload("res://scenes/dialogs/IpElementSelect.tscn")


func _ready():
	# Cargamos lista de ips en la red:
	var ipAddreeses = IP.get_local_addresses()
	var indx: int = 0
	for ip in ipAddreeses:
		if indx % 2 == 0:
			var newIpElement = IP_ELEMENT.instantiate()
			newIpElement.set_data(ipAddreeses[indx],ipAddreeses[indx+1])
			newIpElement.selected.connect(_handle_ip_selected)
			# Los agregamos al contenedor
			%IpContainer.add_child(newIpElement)
		indx += 1

func _handle_ip_selected(_ip_address: Dictionary) -> void:
	emit_signal("ip_selected",_ip_address)
	queue_free()


# Funcion que se ejecuta cuando se presiona el botón cancel
func _on_button_pressed():
	_on_close_requested()

# Funcion que se ejecuta cuando se presiona el botón exit de la ventana
func _on_close_requested():
	queue_free()
