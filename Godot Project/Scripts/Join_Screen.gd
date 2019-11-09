extends Control

func _on_Join_Button_pressed():
	join_game($All/HBoxContainer/LineEdit.text)

func _on_LineEdit_text_entered(new_text):
	join_game(new_text)
	
	
func join_game(ip):
	global.create_client(ip)
	# TODO: change screen



