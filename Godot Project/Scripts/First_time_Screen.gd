extends Control

func _ready():
	pass

func _on_Pseudo_field_text_entered(new_text):
	save_infos(new_text)
	print("test")

func save_infos(pseudo):
	var file = File.new()
	file.open("res://Saved_files.save", File.WRITE)
	
	file.store_line(to_json({"pseudo": pseudo}))
	file.close()