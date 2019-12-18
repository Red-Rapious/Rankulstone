extends Control

var selected_deck = null

func _ready():
	update_deck_collection()
	set_selected_deck(decks.actual_deck)
	if len(decks.saved_decks) == 1:
		set_selected_deck(decks.saved_decks[0])

func update_deck_collection():
	clean_deck_collection()
	
	for deck in decks.saved_decks:
		var scene = load("res://Scenes/Menus/GUI/Deck_button.tscn")
		var scene_instance = scene.instance()
		scene_instance.deck_name = deck
		scene_instance.connect("deck_pressed", self, "set_selected_deck")
		$All/Deck_ScrollContainer/HBoxContainer.add_child(scene_instance)
	
	
func clean_deck_collection():
	for deck in $All/Deck_ScrollContainer/HBoxContainer.get_children():
		deck.queue_free()
	
	
func set_selected_deck(new_deck: String):
	selected_deck = new_deck
	decks.actual_deck = selected_deck
	
	for deck in $All/Deck_ScrollContainer/HBoxContainer.get_children():
		if deck.deck_name == selected_deck:
			deck.set_border(true)
		else:
			deck.set_border(false)
