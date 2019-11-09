extends Node

const IS_LOCAL = true
const PORT = 5000

func create_server():
	if not IS_LOCAL:
		var upnp = UPNP.new()
		print("Discover the network with " + str(PORT) + " port... Output: "+ str(upnp.discover(2000, 2, "InternetGatewayDevice")))
		print("Add the port to port mapping... Output: "+str(upnp.add_port_mapping(PORT)))
	
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(PORT, 1)
	get_tree().set_network_peer(peer)
	print("Successfully created a server with IP: ", IP.get_local_addresses())
	
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	
	
func create_client(ip):
	print(ip)
	get_tree().connect("connected_to_server", self, "connected")
	get_tree().connect("connection_failed", self, "failed")
	
	var peer = NetworkedMultiplayerENet.new()
	
	if IS_LOCAL:
		peer.create_client("192.168.1.191", PORT)
	else:
		peer.create_client("82.255.203.114", PORT)
		
	get_tree().set_network_peer(peer)
	
	

func _player_connected(id):
	print("Player ", id, " is connected!")
	
func _player_disconnected(id):
	print("Player ", id, " leaved the game")
	

func connected():
	print("Successfully connected to the server!")
	rpc("sayhello")
	
func failed():
	print("Connection failed...")
	
		
remote func sayhello():
	print("Hello, I'm "+ str(get_tree().get_network_unique_id()))