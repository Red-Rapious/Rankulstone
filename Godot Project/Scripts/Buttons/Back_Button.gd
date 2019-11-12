extends Button


func _on_Back_Button_pressed():
	network.delete_network()
	get_tree().change_scene("Scenes/Menus/Title_Screen.tscn")
