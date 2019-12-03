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

var self_board = Array()
var opponent_board = Array()

signal game_started

signal self_hand_changed
signal self_library_changed
signal self_pv_changed
signal self_creature_played
signal self_creature_died
signal self_mana_changed
signal self_mana_max_changed

signal opponent_hand_changed
signal opponent_library_changed
signal opponent_pv_changed
signal opponent_creature_played
signal opponent_creature_died
signal opponent_mana_changed
signal opponent_mana_max_changed

signal self_end_of_turn
signal opponent_end_of_turn
signal self_tour_begin

signal self_creature_fight
signal opponent_creature_fight

signal self_creature_attack_opponent

signal self_creature_hp_changed
signal opponent_creature_hp_changed


func init():
	"""
	Called when a 1v1 game start.
	Connect signals, draw a hand, and temporarly create a 30 "Card" library
	"""
	connect("self_hand_changed", self, "_on_self_hand_changed")
	connect("self_library_changed", self, "_on_self_library_changed")
	connect("self_pv_changed", self, "_on_self_pv_changed")

	connect("self_creature_played", self, "_on_self_creature_played")
	connect("self_creature_died", self, "_on_self_creature_died")
	connect("self_tour_begin", self, "_on_self_tour_begin")

	connect("self_mana_changed", self, "_on_self_mana_changed")
	connect("self_mana_max_changed", self, "_on_self_mana_max_changed")
	
	connect("self_creature_fight", self, "_on_self_creature_fight")
	connect("self_creature_hp_changed", self, "_on_self_creature_hp_changed")

	for i in range(30): # temporarly create a full of "Card" cards library
		library.append("Creature")

	draw_hand()
	set_self_pv(self_pv)
	emit_signal("self_mana_max_changed")
	emit_signal("opponent_mana_max_changed")
	emit_signal("self_mana_changed")
	emit_signal("opponent_mana_changed")
	emit_signal("game_started")


"""
Some self signals implementation
Generaly follow the patern:
	on self xxx changed
	say to the opponent that xxx changed
"""
func _on_self_hand_changed():
	rpc("opponent_hand_changed", len(hand))

func _on_self_library_changed():
	rpc("opponent_library_changed", len(library))

func _on_self_pv_changed():
	rpc("opponent_pv_changed", self_pv)
	pv_check() # see if after this pv change, the player loose
	
func _on_self_creature_played(new_card_name: String):
	self_board.append(new_card_name)
	rpc("opponent_creature_played", new_card_name)
	
func _on_self_creature_died(data):
	#self_board.append(card_name)
	rpc("opponent_creature_died", data)
	
	
func _on_self_mana_changed():
	rpc("opponent_mana_changed", self_mana)

func _on_self_mana_max_changed():
	rpc("opponent_mana_max_changed", self_mana_max)
	
func _on_self_creature_fight(data):
	emit_signal("self_creature_hp_changed", [data[global.SELF_CREATURE_DATA], -data[global.OPPONENT_CREATURE_DATA]["attack_value"]])
	emit_signal("self_creature_hp_changed", [data[global.OPPONENT_CREATURE_DATA], -data[global.SELF_CREATURE_DATA]["attack_value"]])
	rpc("opponent_creature_fight", data)

func _on_self_creature_hp_changed(data):
	rpc("opponent_creature_hp_changed", data)
	
""" End """


# some pv setters
func set_self_pv(new_value: int):
	"""
	Set the player pv to a certain amount
	"""
	self_pv = new_value
	emit_signal("self_pv_changed")

remote func add_self_pv(value: int):
	"""
	Add a certain amount of pv to the player.
	If the value given is negative, it will remove some pv
	"""
	self_pv += value
	emit_signal("self_pv_changed")

func pv_check():
	"""
	A function that check if pv is 0 or less.
	If true, it send a message to say that the player loosed
	"""
	if self_pv <= 0:
		loose(true)
# end


# some drawing functions
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
# end



"""
Functions called via rpc by the opponent
See _on_xxx_changed()

Update the good variables
"""
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

remote func opponent_creature_played(new_card_name: String):
	"""
	Called by the player who change board, on the opponent side, like when plays a card
	"""
	#add_self_pv(-10)
	opponent_board.append(new_card_name)
	emit_signal("opponent_creature_played", new_card_name)
	
remote func opponent_creature_died(data):
	"""
	Called by the player who change board, on the opponent side, like when plays a card
	"""
	#opponent_board.append(card_name)
	emit_signal("opponent_creature_died", data)

remote func opponent_mana_changed(new_value: int):
	opponent_mana = new_value
	emit_signal("opponent_mana_changed")

remote func opponent_mana_max_changed(new_value: int):
	opponent_mana_max = new_value
	emit_signal("opponent_mana_changed")
	
remote func opponent_creature_fight(data):
	emit_signal("opponent_creature_fight", data)
	
remote func opponent_creature_hp_changed(data):
	emit_signal("opponent_creature_hp_changed", data)

""" End """




func card_played_from_hand(card_name, mana_cost):
	"""
	Called by BattleScreen when a card is played via d&d
	Delete a card from the hand array
	"""
	hand.erase(card_name)
	add_self_mana(-mana_cost)
	emit_signal("self_hand_changed")
	emit_signal("self_creature_played", card_name)


# functions about tour end 
func end_of_turn():
	"""
	Called when the button is pressed
	"""
	emit_signal("self_end_of_turn")
	rpc("opponent_end_of_turn")
	your_turn = false

remote func opponent_end_of_turn():
	"""
	Called by the opponent on his end of turn
	This means its now your turn
	"""
	emit_signal("opponent_end_of_turn")
	your_turn = true
	emit_signal("self_tour_begin")
	
func creature_died(data):
	"""
	Called when a creature died
	"""
	if data["is_self_side"]:
		emit_signal("self_creature_died", data)
	else:
		emit_signal("opponent_creature_died", data)


func _on_self_tour_begin():
	draw_card()
	set_self_mana_max(self_mana_max+1)

func _on_first_player_tour():
	"""
	Specific lines for the player who play first
	"""
	your_turn = true
	set_self_mana_max(1) # add an initial mana, else he cant play
# end




# some mana & mana max setters
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
# end 



# functions called by self or the opponent when something makes loose or win
remote func loose(inform_opponent: bool):
	"""
	To avoid cyclic calls, a bool is passed in argument
	If this bool is true, it call the opponent, but with a false bool, so the opponent will not call us again
	"""
	if inform_opponent:
		rpc("win", false) # pass the info to the opponent
	end_game(false) # end game with loose
	
remote func win(inform_opponent: bool):
	"""
	Same as loose(), except in this case we won
	"""
	if inform_opponent:
		rpc("loose", false) # pass the info to the opponent
	end_game(true) # end game with win
	
func end_game(win: bool):
	"""
	Called by win() or loose()
	Save the result of the game for the EndGameScreen
	"""
	global.win=win
	get_tree().change_scene("Scenes/Menus/End_game_Screen.tscn")
# end
	
	
	
	
	
func self_card_attack_opponent(data):
	"""
	Called by BattleScreen when an attack against the opponent has been requested
	"""
	emit_signal("self_creature_attack_opponent", data)
	rpc("add_self_pv", -data["attack_value"])
	

func fight_requested(data):
	"""
	Called by a creature when a fight has been requested by d&d
	"""
	emit_signal("self_creature_fight", data)
	
	
	
	
	
	
