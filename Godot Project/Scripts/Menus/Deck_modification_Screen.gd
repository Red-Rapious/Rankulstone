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
	var contains = false
	for i in cards_in_deck:
		if i["node_name"] == node_name:
			contains=true
			i["number"] = i["number"]+1
			break
			
	if not contains:
		cards_in_deck.append({"node_name": node_name, "card_name": card_name, "number": 1})
	update_cards_labels()
	
	
	
	
func update_cards_labels():
	clean_cards_labels()
	
	for i in cards_in_deck:
		var scene = Label.new()
		scene.text = str(i["number"])+ "x "+ i["card_name"]
		$All/Modifications/In_deck/Cards.add_child(scene)

func clean_cards_labels():
	for child in $All/Modifications/In_deck/Cards.get_children():
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
