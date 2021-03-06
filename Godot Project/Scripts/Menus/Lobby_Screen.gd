extends Control

var selected_deck = ""

func _ready():
	update_deck_collection()
	set_selected_deck(decks.actual_deck)
	if len(decks.saved_decks) == 1:
		set_selected_deck(decks.saved_decks[0])

func update_deck_collection():
	clean_deck_collection()
	
	for deck in decks.saved_decks:
		var scene = load("res://Scenes/Buttons/Deck_button.tscn")
		var scene_instance = scene.instance()
		scene_instance.deck_name = deck
		scene_instance.connect("deck_pressed", self, "set_selected_deck")
		$All/Deck_ScrollContainer/HBoxContainer.add_child(scene_instance)
		
	if $All/Deck_ScrollContainer/HBoxContainer.get_children() == []:
		var label = Label.new()
		label.text = "Aucun deck, veuillez en créer un pour commencer à jouer"
		label.size_flags_horizontal = Label.SIZE_EXPAND_FILL
		label.align = Label.ALIGN_CENTER
		$All/Deck_ScrollContainer/HBoxContainer.add_child(label)
	
func clean_deck_collection():
	for deck in $All/Deck_ScrollContainer/HBoxContainer.get_children():
		deck.queue_free()
	
	
func set_selected_deck(new_deck: String):
	selected_deck = new_deck
	decks.actual_deck = selected_deck
	
	for deck in $All/Deck_ScrollContainer/HBoxContainer.get_children():
		if not deck is Label:
			if deck.deck_name == selected_deck:
				deck.set_border(true)
			else:
				deck.set_border(false)
			
			
func _on_Create_Button_pressed():
	if selected_deck != "" and decks.saved_decks!=[]:
		get_tree().change_scene("Scenes/Menus/Waiting_Screen.tscn")
	
func _on_Join_Button_pressed():
	if selected_deck != "" and decks.saved_decks!=[]:
		get_tree().change_scene("Scenes/Menus/Join_Screen.tscn")


func _on_Open_deck_collection_Button_pressed():
	get_tree().change_scene("Scenes/Menus/Deck_collection_Screen.tscn")
