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
	
func _player_disconnected(id):
	print("Player ", id, " leaved the game")
	
func _connected():
	print("Successfully connected to the server!")
	rpc("sayhello")
	
func _failed():
	print("Connection failed...")
	
	
remote func sayhello():
	print("Hello, I'm "+ str(get_tree().get_network_unique_id()))