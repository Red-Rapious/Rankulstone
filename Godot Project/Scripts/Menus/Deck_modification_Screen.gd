extends Control

var cards_in_deck = []
var deck_dico

func _ready():
	deck_dico = decks.load_deck(decks.actual_deck)
	cards_in_deck = deck_dico["cards"]
	
	update_deck_name_label()
	update_cards_labels()
	update_card_collection()
	
	
func update_deck_name_label():
	$All/Header/Deck_name.text = "Modification en cours : " + decks.actual_deck.capitalize()
	
func grid_card_pressed(node_name, card_name):
	"""
	Called by a card in the collection when it's pressed
	Add a card to the deck
	"""
	
	add_card_to_in_deck(node_name, card_name)
	update_cards_labels()
	
	
func add_card_to_in_deck(node_name, card_name):
	var contains = false
	for i in cards_in_deck:
		if i["node_name"] == node_name:
			contains=true
			i["number"] = i["number"]+1
			break
			
	if not contains:
		cards_in_deck.append({"node_name": node_name, "card_name": card_name, "number": 1})
	
	
func update_cards_labels():
	clean_cards_labels()
	
	var card_total = 0
	
	for i in cards_in_deck:
		var scene = load("res://Scenes/Buttons/In_deck_card_Button.tscn")
		var scene_instance = scene.instance()
		scene_instance.init(i["card_name"], i["number"])
		$All/Modifications/In_deck/Cards_ScrollContainer/Cards.add_child(scene_instance)
		
		
		card_total += i["number"]
	
	$All/Modifications/In_deck/Down_Label.text = "Total : "+str(card_total)+"/30"
	
func clean_cards_labels():
	for child in $All/Modifications/In_deck/Cards_ScrollContainer/Cards.get_children():
		child.queue_free()
		
		
		
		
func update_card_collection():
	clean_card_collection()
	
	for i in global.card_index:
		var scene = load("res://Scenes/Cards/"+i+".tscn")
		var scene_instance = scene.instance()
		scene_instance.on_collection = true
		$All/Modifications/ScrollContainer/Collection.add_child(scene_instance)
	
func clean_card_collection():
	for child in $All/Modifications/ScrollContainer/Collection.get_children():
		child.queue_free()
	
	
	
func _on_Save_pressed():
	decks.save_deck(decks.actual_deck, 0, cards_in_deck)
	
	
func _on_Quit_pressed():
	get_tree().change_scene("Scenes/Menus/Title_Screen.tscn")
	
func in_deck_card_button_pressed(card_name):
	for i in cards_in_deck:
		if i["card_name"] == card_name:
			i["number"] -= 1
			if i["number"] <= 0:
				cards_in_deck.erase(i)
			
	update_cards_labels()
