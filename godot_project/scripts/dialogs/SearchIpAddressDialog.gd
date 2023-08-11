extends Window

#Escenas:
@onready var IP_ELEMENT = preload("res://scenes/dialogs/IpElementSelect.tscn")


func _ready():
	# Cargamos lista de ips en la red:
	var ipAddreeses = IP.get_local_addresses()
	var indx: int = 0
	for ip in ipAddreeses:
		if indx % 2 == 0:
			var newIpElement = IP_ELEMENT.instantiate()
#			print(ip)
			newIpElement.set_data(ipAddreeses[indx],ipAddreeses[indx+1])
			%IpContainer.add_child(newIpElement)
		indx += 1
