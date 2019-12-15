extends Control

const PASS = "rankulstone"

func _ready():
	load_deck("deck1")

func save_deck(deck_name):
	var file = File.new()
	file.open_encrypted_with_pass("res://Saved_files/Decks/"+deck_name+".deck", File.WRITE, PASS)
	
	var header = {"name": "My deck", "image": 3}
	var cards = [{"name": "Card", "number": 4}, {"name": "Creature", "number": 5}]
	
	file.store_line(to_json(header))
	file.store_line(to_json({"cards": cards}))
	file.close()
	
func load_deck(deck_name):
	var file = File.new()
	if not file.file_exists("res://Saved_files/Decks/"+deck_name+".deck"):
        return 
	
	file.open_encrypted_with_pass("res://Saved_files/Decks/"+deck_name+".deck", File.READ, PASS)
	var header = parse_json(file.get_line())
	
	var cards = parse_json(file.get_line())["cards"]
	
	print("Lecture du deck : ", header["name"])
	for card in cards:
		print(card["name"], " est en ", card["number"], " exemplaires")