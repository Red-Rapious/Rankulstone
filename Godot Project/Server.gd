extends Button

func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")

func _on_Server_pressed():
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(666, 10)
	get_tree().set_network_peer(peer)
	print("Successfully created a server with IP: ", IP.get_local_addresses())
	
func _player_connected(id):
	print("Player ", id, " is connected!")