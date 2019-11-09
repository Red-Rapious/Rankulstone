extends Button

"""
func _on_Join_Button_pressed():
	get_tree().connect("connected_to_server", self, "connected")
	get_tree().connect("connection_failed", self, "failed")
	
	var peer = NetworkedMultiplayerENet.new()
	
	if global.IS_LOCAL:
		peer.create_client("192.168.1.191", global.PORT)
	else:
		peer.create_client("82.255.203.114", global.PORT)
		
	get_tree().set_network_peer(peer)
"""


func _on_Join_Button_pressed():
	global.create_client()
	get_tree().change_scene("Scenes/Menus/Join_Screen.tscn")