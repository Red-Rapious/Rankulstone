extends Node

const PASS = "rankulstone"
var actual_deck = "deck1"
var saved_decks = []

func _ready():
	load_decks_index()

func save_deck(deck_name: String, image: int, cards):
	"""
	Save the given deck in a .deck encrypted file
	"""
	
	var file = File.new()
	file.open_encrypted_with_pass("res://Saved_files/Decks/"+deck_name+".deck", File.WRITE, PASS)
	
	#var header = {"name": "Deck 1", "image": 0}
	var header = {"name": deck_name, "image": image}
	
	file.store_line(to_json(header))
	file.store_line(to_json({"cards": cards}))
	file.close()
	
	if not deck_name in saved_decks:
		saved_decks.append(deck_name)
		save_decks_index()
		
		
		
func save_decks_index():
	"""
	Save the decks index in a .deck file
	"""
	var file = File.new()
	file.open_encrypted_with_pass("res://Saved_files/Decks/decks_index.deck", File.WRITE, PASS)
	file.store_line(to_json(saved_decks))
	file.close()
	
	
func load_decks_index():
	"""
	Load deck index, and put all the decks names in saved_decks list
	"""
	var file = File.new()
	if not file.file_exists("res://Saved_files/Decks/decks_index.deck"):
		save_decks_index()
		return 
	
	file.open_encrypted_with_pass("res://Saved_files/Decks/decks_index.deck", File.READ, PASS)
	
	saved_decks = parse_json(file.get_line())
	
	file.close()
	
	
	
	
func load_deck(deck_name: String):
	"""
	Load the deck with the given name
	"""
	var file = File.new()
	if not file.file_exists("res://Saved_files/Decks/"+deck_name+".deck"):
        save_deck(deck_name, 0, []) # create an empty deck 
	
	file.open_encrypted_with_pass("res://Saved_files/Decks/"+deck_name+".deck", File.READ, PASS)
	var header = parse_json(file.get_line())
	
	var cards = parse_json(file.get_line())["cards"]
	
	var library = []
	
	for card in cards:
		library.append({"node_name": card["node_name"], "card_name": card["card_name"], "number": card["number"]})
		
			
	return {"name": header["name"], "image": header["image"], "cards": library}
	
	
func set_actual_deck(deck_name: String):
	actual_deck = deck_name
	
	
func delete_deck(deck_name: String):
	"""
	Delete the deck, in saved_decks, deck_index file, and destroy the deck file
	"""
	if deck_name in saved_decks:
		saved_decks.erase(deck_name)
		save_decks_index()
	var dir = Directory.new()
	dir.remove("res://Saved_files/Decks/"+deck_name+".deck")
		
func delete_all_decks():
	"""
	Delete_deck() with all decks
	"""
	for deck in saved_decks:
		delete_deck(deck)
	save_decks_index()