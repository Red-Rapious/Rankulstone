extends Control

func _ready():
	var file = File.new()
	file.open("res://Saved_files/infos.save", File.READ)
	var pseudo = parse_json(file.get_line())
	var saved = parse_json(file.get_line())
	if saved:
		get_tree().change_scene("Scenes/Menus/Title_Screen.tscn")
	file.close()

func _on_Pseudo_field_text_entered(new_text):
	save_infos(new_text)

func save_infos(pseudo):
	global.player_pseudo = pseudo
	var file = File.new()
	file.open("res://Saved_files/infos.save", File.WRITE)
	
	file.store_line(to_json({"pseudo": pseudo}))
	file.store_line(to_json({"saved": true}))
	file.close()
	
	get_tree().change_scene("Scenes/Menus/Title_Screen.tscn")