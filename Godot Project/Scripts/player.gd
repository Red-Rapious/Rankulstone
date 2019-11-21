# a global script for all in-game needs, but particulary for values storage
extends Node

var self_mana_max = 0
var self_mana = self_mana_max

var opponent_mana_max = 0
var opponent_mana = opponent_mana_max

var your_turn = false

var self_pv = 30
var opponent_pv

var opponent_hand_size = 7
var hand = Array()

var opponent_library_size = 30
var library = Array()


signal self_hand_changed
signal self_library_changed
signal self_pv_changed
signal self_board_changed
signal self_mana_changed
signal self_mana_max_changed

signal opponent_hand_changed
signal opponent_library_changed
signal opponent_pv_changed
signal opponent_board_changed
signal opponent_mana_changed
signal opponent_mana_max_changed

signal self_end_of_turn
signal opponent_end_of_turn
signal self_tour_begin

	
func init():
	"""
	Called when a 1v1 game start.
	Connect signals, draw a hand, and temporarly create a 30 "Card" library
	"""
	connect("self_hand_changed", self, "_on_self_hand_changed")
	connect("self_library_changed", self, "_on_self_library_changed")
	connect("self_pv_changed", self, "_on_self_pv_changed")
	
	connect("self_board_changed", self, "_on_self_board_changed")
	connect("self_tour_begin", self, "_on_self_tour_begin")
	
	connect("self_mana_changed", self, "_on_self_mana_changed")
	connect("self_mana_max_changed", self, "_on_self_mana_max_changed")
	
	for i in range(30): # temporarly create a full of "Card" cards library
		library.append("Card")
		
	draw_hand()
	set_self_pv(self_pv)
	emit_signal("self_mana_max_changed")
	emit_signal("opponent_mana_max_changed")
	emit_signal("self_mana_changed")
	emit_signal("opponent_mana_changed")
	
	
	
func _on_self_hand_changed():
	rpc("opponent_hand_changed", len(hand))
	
func _on_self_library_changed():
	rpc("opponent_library_changed", len(library))

func _on_self_pv_changed():
	rpc("opponent_pv_changed", self_pv)

func set_self_pv(new_value: int):
	"""
	Set the player pv to a certain amount
	"""
	self_pv = new_value
	emit_signal("self_pv_changed")
	
func add_self_pv(value: int):
	"""
	Add a certain amount of pv to the player. 
	If the value given is negative, it will remove some pv
	"""
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

func draw_card(signalised=true):
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
	
func _on_self_board_changed(new_card_name: String):
	rpc("opponent_board_changed", new_card_name)
	
remote func opponent_board_changed(new_card_name: String):
	"""
	Called by the player who change board
	"""
	emit_signal("opponent_board_changed", new_card_name)
	
	
func card_played_from_hand(card_name):
	"""
	Delete a card from the hand array
	"""
	hand.erase(card_name)
	emit_signal("self_hand_changed")
	emit_signal("self_board_changed", card_name)
	
func end_of_turn():
	emit_signal("self_end_of_turn")
	rpc("opponent_end_of_turn")
	your_turn = false
	
remote func opponent_end_of_turn():
	emit_signal("opponent_end_of_turn")
	your_turn = true
	emit_signal("self_tour_begin")
	
func _on_self_tour_begin():
	draw_card()
	set_self_mana_max(self_mana_max+1)
	
func _on_first_player_tour():
	your_turn = true
	set_self_mana_max(1)
	
func set_self_mana(new_value: int):
	self_mana = new_value
	if self_mana>self_mana_max:
		self_mana = self_mana_max
	emit_signal("self_mana_changed")
	
func set_self_mana_max(new_value: int):
	self_mana_max = new_value
	if self_mana_max>10:
		self_mana_max = 10
	full_mana_bar()
	emit_signal("self_mana_max_changed")
	
func add_self_mana(value: int):
	set_self_mana(self_mana + value)
	
func full_mana_bar():
	set_self_mana(self_mana_max)
	
remote func opponent_mana_changed(new_value: int):
	opponent_mana = new_value
	emit_signal("opponent_mana_changed")
	
remote func opponent_mana_max_changed(new_value: int):
	opponent_mana_max = new_value
	emit_signal("opponent_mana_changed")
	
func _on_self_mana_changed():
	rpc("opponent_mana_changed", self_mana)
	
func _on_self_mana_max_changed():
	rpc("opponent_mana_max_changed", self_mana_max)