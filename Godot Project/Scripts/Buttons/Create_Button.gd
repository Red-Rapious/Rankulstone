extends Button

"""
func _on_Create_Button_pressed():
	if not global.IS_LOCAL:
		var upnp = UPNP.new()
		print("Discover the network with " + str(global.PORT) + " port... Output: "+ str(upnp.discover(2000, 2, "InternetGatewayDevice")))
		print("Add the port to port mapping... Output: "+str(upnp.add_port_mapping(global.PORT)))
	
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(global.PORT, 1)
	get_tree().set_network_peer(peer)
	print("Successfully created a server with IP: ", IP.get_local_addresses())
	
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
"""

func _on_Create_Button_pressed():
	global.create_server()
	get_tree().change_scene("Scenes/Menus/Waiting_Screen.tscn")
