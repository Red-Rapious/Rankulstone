extends Control

func _on_Join_Button_pressed():
	join_game($All/HBoxContainer/LineEdit.text)

func _on_LineEdit_text_entered(new_text):
	join_game(new_text)
	
func join_game(ip): # called when the player hit the "Rejoindre" button or press enter
	network.create_client(ip)


func _connected():
	$All/Join_Label.text = "CHARGEMENT DE LA PARTIE EN COURS..."


func _on_Paste_Button_pressed():
	$All/HBoxContainer/LineEdit.text = OS.get_clipboard()
