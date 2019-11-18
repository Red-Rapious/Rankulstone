# a global script for all in-game needs, but particulary for values storage
extends Node

var mana_max = 10
var mana = mana_max
var self_pv = 30
var opponent_pv
var your_turn = true

var opponent_hand_size = 7
var hand = Array()

var opponent_library_size = 30
var library = Array()

signal self_hand_changed
signal self_library_changed
signal self_pv_changed
signal opponent_hand_changed
signal opponent_library_changed
signal opponent_pv_changed

	
func init():
	"""
	Called when the game start.
	Connect signals, draw a hand, and temporarly create a 30 "Card" library
	"""
	connect("self_hand_changed", self, "_on_self_hand_changed")
	connect("self_library_changed", self, "_on_self_library_changed")
	connect("self_pv_changed", self, "_on_self_pv_changed")
	for i in range(30):
		library.append("Card")
	draw_hand()
	add_self_pv(10)
	
	
	
func _on_self_hand_changed():
	rpc("opponent_hand_changed", len(hand))
	
func _on_self_library_changed():
	rpc("opponent_library_changed", len(library))

func _on_self_pv_changed():
	rpc("opponent_pv_changed", self_pv)

func set_self_pv(new_value: int):
	self_pv = new_value
	emit_signal("self_pv_changed")
	
func add_self_pv(value: int):
	self_pv += value
	emit_signal("self_pv_changed")


func draw_hand(size=7):
	"""
	Draw a hand, by default of 7 cards
	"""
	for i in range(size):
		draw_card(false)
	emit_signal("self_hand_changed")
	emit_signal("self_library_changed")

func draw_card(signalised: bool):
	""" bool -> void
	A function who pick a random card in the library and move it to the hand.
	If signalised, emit signals each when the hand change and the library change.
	"""
	
	if len(library) != 0: # avoid the case of an empty library
		var card_picked = randi()%(len(library))
		hand.append(library[card_picked])
		library.remove(card_picked)
		if signalised:
			emit_signal("self_library_changed")
			emit_signal("self_hand_changed")


remote func opponent_hand_changed(new_value: int):
	"""
	Called by the player who changed hand (change size, etc) on his opponent side
	"""
	opponent_hand_size = new_value
	emit_signal("opponent_hand_changed")
	
remote func opponent_library_changed(new_value: int):
	"""
	Called by the player who changed library (change size, etc) on his opponent side
	"""
	opponent_library_size = new_value
	emit_signal("opponent_library_changed")
	
remote func opponent_pv_changed(new_value: int):
	"""
	Called by the player who pv on his opponent side
	"""
	opponent_pv = new_value
	emit_signal("opponent_pv_changed")
	
	
	
func card_played(card_name):
	"""
	Delete a card from the hand array
	"""
	hand.erase(card_name)
	emit_signal("self_hand_changed")