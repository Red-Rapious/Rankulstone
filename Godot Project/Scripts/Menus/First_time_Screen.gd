extends Control

func _ready():
	# open infos.save to check if the player have already enter his informations
	read_infos()
	if global.is_player_information_loaded: # if the player is already saved
		get_tree().change_scene("Scenes/Menus/Title_Screen.tscn") # go to the title screen

func save_infos(pseudo: String):
	"""
	A function that saves player informations to a file, and go to the title screen
	"""
	global.self_pseudo = pseudo
	var file = File.new()
	file.open("res://Saved_files/infos.save", File.WRITE)
	
	file.store_line(to_json({"pseudo": pseudo}))
	#file.store_line(to_json({"saved": true}))
	file.close()
	
	get_tree().change_scene("Scenes/Menus/Title_Screen.tscn")
	
func read_infos():
	"""
	A function that open a file and load all the informations it contains
	to specific variables
	"""
	var file = File.new()
	if file.file_exists("res://Saved_files/infos.save"):
		file.open("res://Saved_files/infos.save", File.READ)
		var pseudo = parse_json(file.get_line())
		global.self_pseudo = pseudo["pseudo"]
		#var saved = parse_json(file.get_line())
		global.is_player_information_loaded = true
	file.close()
	
func _on_Pseudo_field_text_entered(new_text):
	save_infos(new_text)