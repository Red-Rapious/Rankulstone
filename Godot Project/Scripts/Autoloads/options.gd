extends Node

var options_dico = {"toggle_fullscreen": false}

func _ready():
	load_options()

func save_options():
	var file = File.new()
	file.open("res://Saved_files/options.save", File.WRITE)
	file.store_line(to_json(options_dico))
	file.close()
	
func load_options():
	var file = File.new()
	if not file.file_exists("res://Saved_files/options.save"):
		return 
	
	file.open("res://Saved_files/options.save", File.READ)
	
	var dico = parse_json(file.get_line())
	options_dico = dico
	
	
	file.close()
	