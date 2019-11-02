extends Button


func _on_Client_pressed():
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client("82.255.203.114", 666)
	get_tree().set_network_peer(peer)
	

