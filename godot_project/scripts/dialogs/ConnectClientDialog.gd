extends Window

# Escenas:
var SEARCH_IP_DIALOG := preload("res://scenes/dialogs/SearchIpAddressDialog.tscn")


# Esta función se ejecuta cuando presionamos el boton buscar
func _on_button_buscar_pressed() -> void:
	# Creamos ventana de buscar direcciones IP en la red
	var newDialog = SEARCH_IP_DIALOG.instantiate()
	newDialog.ip_selected.connect(handle_search_ip_dialog_ip_selected)
	get_parent().add_child(newDialog)

# Esta función se ejecuta cuando recibimos la señal "ip_selected"
func handle_search_ip_dialog_ip_selected(new_ip) -> void:
	%LineEditIp.set("text",new_ip["ip_address"])


# Esta funcion se ejecuta cuando presionamos el botón conectar
func _on_button_conectar_pressed():
	var ip_address: String = %LineEditIp.get("text")
	var port: int = %SpinBoxPort.get("value")
	UdpServer.connect_to_client(ip_address, port)
	pass # Replace with function body.


# Esta función se ejecuta cuando presionamos el botón volver
func _on_button_volver_pressed():
	queue_free()

