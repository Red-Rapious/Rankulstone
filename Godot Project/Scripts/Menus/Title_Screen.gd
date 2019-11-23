extends Control

func _ready():
	#load_infos()
	pass

func load_infos():
	var file = File.new()
	if not file.file_exists("res://Saved_files/infos.save"):
		get_tree().change_scene("Scenes/Menus/First_time_Screen.tscn")

	file.open("res://Saved_files/infos.save", File.READ)
	
	var pseudo = parse_json(file.get_line())
	var saved = parse_json(file.get_line())
	if not saved:
		get_tree().change_scene("Scenes/Menus/First_time_Screen.tscn")
	file.close()