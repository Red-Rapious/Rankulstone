extends Control

func _ready():
	update_deck_name_label()
	
func update_deck_name_label():
	$All/Header/Deck_name.text = "Modification en cours : " + decks.actual_deck.capitalize()

