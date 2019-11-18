extends Control

func _ready():
	# open infos.save to check if the player have already enter his informations
	var file = File.new()
	file.open("res://Saved_files/infos.save", File.READ)
	var pseudo = parse_json(file.get_line())
	var saved = parse_json(file.get_line())
	if saved: # if the player is already saved
		get_tree().change_scene("Scenes/Menus/Title_Screen.tscn") # go to the title screen
	file.close()

func _on_Pseudo_field_text_entered(new_text):
	save_infos(new_text)

func save_infos(pseudo: String):
	"""
	A function that saves player informations to a file, and go to the title screen
	"""
	global.player_pseudo = pseudo
	var file = File.new()
	file.open("res://Saved_files/infos.save", File.WRITE)
	
	file.store_line(to_json({"pseudo": pseudo}))
	file.store_line(to_json({"saved": true}))
	file.close()
	
	get_tree().change_scene("Scenes/Menus/Title_Screen.tscn")