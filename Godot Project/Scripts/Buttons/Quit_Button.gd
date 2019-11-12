extends Button

func _on_Quit_Button_pressed():
	network.delete_network()
	get_tree().change_scene("Scenes/Menus/Lobby_Screen.tscn")
