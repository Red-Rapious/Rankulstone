extends Node

const PASS = "rankulstone"
var actual_deck = "deck1"
var saved_decks = []

func _ready():
	load_decks_index()

func save_deck(deck_name):
	var file = File.new()
	file.open_encrypted_with_pass("res://Saved_files/Decks/"+deck_name+".deck", File.WRITE, PASS)
	
	var header = {"name": "Deck 1", "image": 0}
	var cards = [
	{"name": "Flash_kick", "number": 3}, 
	{"name": "Sylas", "number": 3},
	{"name": "Soraka", "number": 3}, 
	{"name": "Electrocution", "number": 3},
	{"name": "Sbire_mage", "number": 3}, 
	{"name": "Sbire_canon", "number": 3}, 
	{"name": "Super_sbire", "number": 3}, 
	{"name": "Vol", "number": 3}
	]
	
	file.store_line(to_json(header))
	file.store_line(to_json({"cards": cards}))
	file.close()
	
	if not deck_name in saved_decks:
		saved_decks.append(deck_name)
		save_decks_index()
		
		
func save_decks_index():
	var file = File.new()
	file.open_encrypted_with_pass("res://Saved_files/Decks/decks_index.deck", File.WRITE, PASS)
	file.store_line(to_json(saved_decks))
	file.close()
	
	
func load_decks_index():
	var file = File.new()
	if not file.file_exists("res://Saved_files/Decks/decks_index.deck"):
        return 
	
	file.open_encrypted_with_pass("res://Saved_files/Decks/decks_index.deck", File.READ, PASS)
	
	saved_decks = parse_json(file.get_line())
	
	file.close()
	
	save_deck(saved_decks[0])
	
func load_deck(deck_name):
	var file = File.new()
	if not file.file_exists("res://Saved_files/Decks/"+deck_name+".deck"):
        return 
	
	file.open_encrypted_with_pass("res://Saved_files/Decks/"+deck_name+".deck", File.READ, PASS)
	var header = parse_json(file.get_line())
	
	var cards = parse_json(file.get_line())["cards"]
	
	var library = []
	for card in cards:
		for i in range(card["number"]):
			library.append(card["name"])
		
			
	return {"name": header["name"], "image": header["image"], "library": library}
	
func set_actual_deck(deck_name):
	actual_deck = deck_name