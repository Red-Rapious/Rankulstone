extends Control

func _on_Join_Button_pressed():
	join_game($All/HBoxContainer/LineEdit.text)

func _on_LineEdit_text_entered(new_text):
	join_game(new_text)
	
	
func join_game(ip):
	network.create_client(ip)

func _connected():
	#get_tree().change_scene("Scenes/Battle_Screen.tscn")
	$All/Join_Label.text = "READY TO LAUNCH THE GAME!"



