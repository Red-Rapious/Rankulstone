extends Button

func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")

func _on_Create_Button_pressed():
	var port = 5000
	var upnp = UPNP.new()
	print(upnp.discover(2000, 2, "InternetGatewayDevice"))
	print(upnp.get_gateway())
	print(upnp.add_port_mapping(port))
	
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(port, 2)
	get_tree().set_network_peer(peer)
	print("Successfully created a server with IP: ", IP.get_local_addresses())
	
func _player_connected(id):
	print("Player ", id, " is connected!")
	
func _player_disconnected(id):
	print("Player ", id, " leaved the game")


"""
func _on_Create_Button_pressed():
	get_tree().change_scene("Scenes/Menus/Waiting_Screen.tscn")"""
