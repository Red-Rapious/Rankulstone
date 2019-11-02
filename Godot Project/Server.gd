extends Button

func _on_Server_pressed():
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(666, 2)
	get_tree().set_network_peer(peer)
	
func _player_connected(id):
	print("Player", id, "connected")