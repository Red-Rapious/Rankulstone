extends Node

var options_dico = {"toggle_fullscreen": false, "request_attention": false, "show_attack_border": true}

func _ready():
	load_options()

func save_options():
	"""
	Save the current options in options_dico to an external file
	"""
	var file = File.new()
	file.open("res://Saved_files/options.save", File.WRITE)
	file.store_line(to_json(options_dico))
	file.close()
	
func load_options():
	"""
	Set the current options to the value of the options in the file
	"""
	var file = File.new()
	if not file.file_exists("res://Saved_files/options.save"):
		return 
	
	file.open("res://Saved_files/options.save", File.READ)
	
	var dico = parse_json(file.get_line())
	options_dico = dico
	
	
	file.close()
	