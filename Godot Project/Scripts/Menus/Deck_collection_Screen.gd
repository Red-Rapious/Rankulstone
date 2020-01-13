extends Control
"""
A screen to select the deck to modify in the Deck_modification_Screen
"""

var selected_deck = null

func _ready():
	update_deck_collection()
	
	
	
	
func update_deck_collection():
	"""
	This functions loads decks button and put them into the grid container
	Also load a new deck button 
	"""
	clean_deck_collection()
	
	# load the decks
	for deck in decks.saved_decks:
		var scene = load("res://Scenes/Buttons/Deck_button.tscn")
		var scene_instance = scene.instance()
		scene_instance.deck_name = deck
		scene_instance.connect("deck_pressed", self, "set_selected_deck")
		$VBoxContainer/GridContainer.add_child(scene_instance)
		
	# add a new deck button
	var scene = load("res://Scenes/Buttons/New_deck_Button.tscn")
	var scene_instance = scene.instance()
	scene_instance.connect("pressed", self, "_on_New_deck_Button_pressed")
	$VBoxContainer/GridContainer.add_child(scene_instance)

func clean_deck_collection():
	for deck in $VBoxContainer/GridContainer.get_children():
		deck.queue_free()



func _on_New_deck_Button_pressed():
	$Popup.popup()

func _on_LineEdit_text_entered(new_text):
	# called when the new deck name is entered
	decks.set_actual_deck(new_text)
	get_tree().change_scene("res://Scenes/Menus/Deck_modification_Screen.tscn")
	
	
func _on_Open_deck_Button_pressed():
	if selected_deck != null:
		decks.set_actual_deck(selected_deck)
		get_tree().change_scene("res://Scenes/Menus/Deck_modification_Screen.tscn")


func _on_Delete_deck_Button_pressed():
	if selected_deck != null:
		decks.delete_deck(selected_deck)
	update_deck_collection()
	
	
func set_selected_deck(new_deck):
	"""
	This function change the selected deck, and add a kind of border to the selected one
	"""
	selected_deck = new_deck
	
	$VBoxContainer/Foot/Open_deck_Button.disabled = false
	$VBoxContainer/Foot/Delete_deck_Button.disabled = false
	
	for deck in $VBoxContainer/GridContainer.get_children():
		if deck.get_filename() != "res://Scenes/Buttons/New_deck_Button.tscn":
			if deck.deck_name == selected_deck:
				deck.set_border(true)
			else:
				deck.set_border(false)


func _on_Delete_all_Button_pressed():
	decks.delete_all_decks()
	update_deck_collection()
