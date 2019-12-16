extends TextureButton

export var deck_name = "deck1"

func _ready():
	update_label()

func _on_Deck_pressed():
	decks.set_actual_deck(deck_name)
	get_tree().change_scene("res://Scenes/Menus/Deck_modification_Screen.tscn")
	
func update_label():
	$Label.text = deck_name.capitalize()
