extends Control

func _ready():
	network.create_server()
	
func _player_connected(id):
	$All/Label.text = "READY TO LAUNCH THE GAME!"
