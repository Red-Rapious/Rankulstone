extends Control

const ICON_NUMBER = 7

var entered_pseudo
var choosed_icon

func _ready():
	# open infos.save to check if the player have already enter his informations
	read_infos()
	
	if global.information_loaded: # if the player is already saved
		get_tree().change_scene("Scenes/Menus/Title_Screen.tscn") # go to the title screen
		
	load_icons_buttons()


func save_infos():
	"""
	A function that saves player informations to a file, and go to the title screen
	"""
	
	global.self_pseudo = entered_pseudo
	var file = File.new()
	file.open("res://Saved_files/infos.save", File.WRITE)
	
	file.store_line(to_json({"pseudo": entered_pseudo, "icon": choosed_icon}))
	file.close()
	
	get_tree().change_scene("Scenes/Menus/Title_Screen.tscn")
	

func read_infos():
	#A function that open a file and load all the informations it contains
	#to specific variables
	
	var file = File.new()
	
	if not file.file_exists("res://Saved_files/infos.save"):
		return
	
	file.open("res://Saved_files/infos.save", File.READ)
	var dict = parse_json(file.get_line())
	if dict != null:
		global.self_pseudo = dict["pseudo"]
		global.self_icon = dict["icon"]
		global.information_loaded = true
	file.close()

	
func load_icons_buttons():
	for child in $VBoxContainer/Icons_ScrollContainer/HBoxContainer.get_children():
		child.queue_free()
	
	
	var scene = load("res://Scenes/Buttons/Icon_Button.tscn")
	for i in ICON_NUMBER:
		var instance = scene.instance()
		instance.icon_number = i
		$VBoxContainer/Icons_ScrollContainer/HBoxContainer.add_child(instance)
	
	
func _on_Pseudo_field_text_entered(new_text):
	entered_pseudo = new_text

func _on_Button_pressed():
	if entered_pseudo != null and choosed_icon != null:
		save_infos()
		
func icon_pressed(icon_num):
	choosed_icon = icon_num
