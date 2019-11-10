extends Control

func _ready():
	network.create_server()
	
func _player_connected(id):
	#get_tree().change_scene("Scenes/Battle_Screen.tscn")
	$All/Label.text = "READY TO LAUNCH THE GAME!"
