extends Button


func _ready():
	get_tree().connect("connected_to_server", self, "connected")
	get_tree().connect("connection_failed", self, "failed")

func _on_Join_Button_pressed():
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client("82.255.203.114", 5000)
	get_tree().set_network_peer(peer)
	

func connected():
	print("Successfully connected!")
	
func failed():
	print("Connection failed...")
	
remote func sayhello():
	print("Hello")
	
"""

func _on_Join_Button_pressed():
	get_tree().change_scene("Scenes/Menus/Join_Screen.tscn")"""