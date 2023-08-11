extends Window

var ip_adresses

# Called when the node enters the scene tree for the first time.
func _ready():
	ip_adresses = IP.get_local_addresses()
	for ip in ip_adresses:
		print(ip)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
