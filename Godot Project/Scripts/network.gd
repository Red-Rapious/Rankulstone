extends Node

const PORT = 5000

func create_server():
	# TODO : dont use UPNP if a checkbox is set to "local"
	var upnp = UPNP.new()
	print("Discover the network with " + str(PORT) + " port... Output: "+ str(upnp.discover(2000, 2, "InternetGatewayDevice")))
	print("Add the port to port mapping... Output: "+str(upnp.add_port_mapping(PORT)))
	
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(PORT, 1)
	get_tree().set_network_peer(peer)
	print("Successfully created a server")# with IP: ", IP.get_local_addresses())
	
	get_tree().connect("network_peer_connected", get_tree().get_current_scene(), "_player_connected")
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	
	
func create_client(ip):
	print("Connecting to: "+ip)
	get_tree().connect("connected_to_server", self, "_connected")
	get_tree().connect("connected_to_server", get_tree().get_current_scene(), "_connected")
	get_tree().connect("connection_failed", self, "_failed")
	
	var peer = NetworkedMultiplayerENet.new()
	
	peer.create_client(ip, PORT)
	# localhost: 192.168.1.191
	# macbook: 82.255.203.114
	
	get_tree().set_network_peer(peer)
	
	
func _player_connected(id):
	print("Player ", id, " is connected. We can finaly start the game!")
	rpc("send_version", global.VERSION)
	# send version to the client, in order to version-check
	
func _player_disconnected(id):
	print("Player ", id, " leaved the game")


func _connected():
	print("Successfully connected to the server!")
	
func _failed():
	print("Connection failed...")
	
	
func launch_game():
	get_tree().change_scene("Scenes/Battle_Screen.tscn")
	
remote func send_version(version): # called on the client when it connect to a game
	if version == global.VERSION: # check if the 2 players version are the sames
		print("No version conflict, game accepted.")
		launch_game()
	else:
		print("Version conflict, you or your opponent need to update Rankulstone to the last version. Game canceled.")
		get_tree().set_network_peer(null) # close the server
		get_tree().change_scene("Scenes/Menus/Lobby_Screen.tscn")