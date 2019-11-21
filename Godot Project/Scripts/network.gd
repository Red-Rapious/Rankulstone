extends Node

const PORT = 5000

func create_server():
	"""
	Create a server on the PORT port, can be called from anywhere
	"""
	# TODO : dont use UPNP if a checkbox is set to "local"
	var upnp = UPNP.new()
	#print("Discover the network with " + str(PORT) + " port... Output: "+ str(upnp.discover(2000, 2, "InternetGatewayDevice")))
	#print("Add the port to port mapping... Output: "+str(upnp.add_port_mapping(PORT)))
	
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(PORT, 1)
	get_tree().set_network_peer(peer)
	#print("Successfully created a server") # with IP: ", IP.get_local_addresses())
	
	get_tree().connect("network_peer_connected", get_tree().get_current_scene(), "_player_connected")
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	
	
func create_client(ip: String):
	"""
	Create a client on the PORT port, with the given argument IP
	"""
	get_tree().connect("connected_to_server", self, "_connected")
	get_tree().connect("connected_to_server", get_tree().get_current_scene(), "_connected")
	get_tree().connect("connection_failed", self, "_failed")
	
	var peer = NetworkedMultiplayerENet.new()
	
	peer.create_client(ip, PORT)
	# localhost: 192.168.1.191
	# macbook: 82.255.203.114
	
	get_tree().set_network_peer(peer)

func delete_network():
	# simply delete network in order to avoid confilcts
	get_tree().set_network_peer(null)
	
func quit_game():
	rpc("opponent_disconnected")
	delete_network()
	
remote func opponent_disconnected():
	print("Opponent disconnected")
	get_tree().change_scene("Scenes/Menus/Title_Screen.tscn")
	delete_network()
	
func _player_connected(id):
	#print("Player ", id, " is connected. We can finaly start the game!")
	rpc("send_version", global.VERSION) # send version to the client, in order to version-check
	
func _player_disconnected(id):
	#print("Player ", id, " leaved the game")
	pass


func _connected():
	#print("Successfully connected to the server!")
	pass
	
func _failed():
	#print("Connection failed...")
	pass
	
	
remote func launch_game():
	"""
	Go to the BattleScreen scene
	Called by the client on both client and server
	"""
	get_tree().change_scene("Scenes/Battle_Screen.tscn")
	
remote func start_first(yes: bool):
	if yes:
		player.your_turn = true
	else:
		player.your_turn = false
	
remote func send_version(version):
	"""
	Check if both versions of the game are the same.
	Called on the client when it connect to a game.
	"""
	if version == global.VERSION: # check if the 2 players version are the sames
		#print("No version conflict, game accepted.")
		
		if randi()%2 == 0:
			start_first(true)
			rpc("start_first",false)
		else:
			start_first(false)
			rpc("start_first",true)
			
		launch_game()
		rpc("launch_game")
	else:
		print("Version conflict, you or your opponent need to update Rankulstone to the last version. Game canceled.")
		delete_network() # close the server
		get_tree().change_scene("Scenes/Menus/Lobby_Screen.tscn") # go back to the lobby