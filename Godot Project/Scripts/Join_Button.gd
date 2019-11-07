extends Button

"""
func _ready():
	get_tree().connect("connected_to_server", self, "connected")
	get_tree().connect("connection_failed", self, "failed")

func _on_Join_Button_pressed():
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client("192.168.0.30", 666)
	get_tree().set_network_peer(peer)
	

func connected():
	print("Successfully connected!")
	
func failed():
	print("Connection failed...")
"""

func _on_Join_Button_pressed():
	get_tree().change_scene("Scenes/Menus/Join_Screen.tscn")