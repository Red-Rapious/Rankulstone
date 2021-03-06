extends "res://Scripts/Cards/Card.gd"
tool

export var pv = 1
export var attack = 1
export var base_keywords = []
var keywords = []

"""
Keywords:
	-Alpha = can attack at first tour
	-Guinsoo = can attack twice by turn
	-Indestructble = can't take damages
	-Defenseur = cant attack
	-Provocation = useless for now
"""

var pv_max = pv
export var has_enter_battlefield_focus = false # if this card have a effect who focus a creature when enter the battlefield

export var turns_before_effect = 0
export var turns_before_appear = 0

var on_board = false
var is_self_side
var can_attack = false # attack is false by default to simulate invocation sickness

# keywords
var guinsoo_available = true

# one turn effects
var one_turn_keywords = []
var one_turn_attack = 0
var one_turn_pv = 0


signal enter_battlefield
signal quit_battlefield

signal attack_changed
signal pv_changed
signal pv_max_changed



func _ready():
	keywords = []
	if base_keywords != []: # weird engine bug
		keywords = base_keywords
	type = CREATURE
	node_name = NAME
	
	connect_signals()
	
	if "Alpha" in keywords:
		can_attack = true # disable invocation sickness
		
	update_labels()
	pv_max = pv
	check_pv()



func connect_signals():
	player.connect("self_tour_begin", self, "_on_self_tour_begin")
	player.connect("self_end_of_turn", self, "_on_self_end_of_turn")
	player.connect("self_creature_attack_opponent", self, "_on_creature_attack_something")
	player.connect("self_creature_fight", self, "_on_creature_fight")

# some attacks setters
func set_attack(new_value: int):
	attack = new_value
	emit_signal("attack_changed")
	
func add_attack(value: int):
	set_attack(attack + value)
	
	
	
	
# some pv & pv_max setters
func set_pv(new_value: int):
	if not ("Indestructible" in keywords or "Indestructible" in one_turn_keywords):
		pv = new_value
	check_pv()
	emit_signal("pv_changed")
	
func add_pv(value: int):
	if value >= 0:
		set_pv(pv + value)
	else:
		if -value <= one_turn_pv:
			add_one_turn_pv(value)
		else:
			set_pv(pv + value + one_turn_pv)
			set_one_turn_pv(0)
			
	
func set_pv_max(new_value: int, fill=true):
	pv_max = new_value
	if fill:
		fill_pv()
	emit_signal("pv_max_changed")
	
func add_pv_max(value: int, fill=true):
	set_pv_max(pv_max + value, fill)
	
func fill_pv(): # simply fill the pv to pv_max
	set_pv(pv_max)
	
func check_pv(): # a function that checks if pv is under 0
	if pv<=0:
		die()
	if pv > pv_max:
		pv = pv_max
		
func add_keyword(keyword: String):
	if not keyword in keywords:
		keywords.append(keyword)
	update_labels()
	
	


# one-turn setters functions
func set_one_turn_attack(new_value: int):
	one_turn_attack = new_value
	emit_signal("attack_changed")
	
func add_one_turn_attack(value: int):
	set_one_turn_attack(one_turn_attack + value)
	
	
func set_one_turn_pv(new_value: int):
	one_turn_pv = new_value
	check_pv()
	emit_signal("pv_changed")
	
func add_one_turn_pv(value: int):
	set_one_turn_pv(one_turn_pv + value)

func add_one_turn_keyword(keyword: String):
	one_turn_keywords.append(keyword)
	update_labels()
	
	

func reset_one_turn_values():
	one_turn_attack = 0
	one_turn_pv = 0
	one_turn_keywords = []
	update_labels()

func play_card(id):
	"""
	Called when this card is played
	Do some routine
	"""
	
	uniq_id = id
	name = str(uniq_id)
	on_board = true
	#enter_battlefield_effect()
	update_labels()
	emit_signal("played")
	
	
func update_labels():
	""" 
	See Card.update_labels
	"""
	update_name()
	update_keywords()
	
	if on_board: # if on board, dont show mana cost
		$VBoxContainer/Top/Mana_cost.visible = false
		$VBoxContainer/Action_Text.visible = false
		$VBoxContainer/Under_text.visible = false
	else:
		$VBoxContainer/Top/Mana_cost.text = str(MANA_COST)
		
	$VBoxContainer/Bottom/PV.text = str(pv+one_turn_pv)
	$VBoxContainer/Bottom/Attack.text = str(attack+one_turn_attack)
	
	update_stats_labels_colors()
	update_border()
	update_tribe_label()

func update_keywords():
	#
	var keywords_text = ""
	for i in keywords:
		keywords_text = keywords_text + i + ", "
		
	for i in one_turn_keywords:
		keywords_text = keywords_text + i + ", "
		
	keywords_text = keywords_text.substr(0, len(keywords_text)-2) # delete last coma
	$VBoxContainer/Keywords.text = keywords_text
	#

func update_border():
	if on_board and can_attack and is_self_side and options.options_dico["show_attack_border"]:
		$Border.visible = true
	else:
		$Border.visible = false

func update_stats_labels_colors():
	if one_turn_pv > 0:
		$VBoxContainer/Bottom/PV.modulate = Color("#00ff09")
	elif one_turn_pv == 0:
		$VBoxContainer/Bottom/PV.modulate = Color("#ffffff")
	elif one_turn_pv < 0:
		$VBoxContainer/Bottom/PV.modulate = Color("#ff0000")
		
	if one_turn_attack > 0:
		$VBoxContainer/Bottom/Attack.modulate = Color("#00ff09")
	elif one_turn_attack == 0:
		$VBoxContainer/Bottom/Attack.modulate = Color("#ffffff")
	elif one_turn_attack < 0:
		$VBoxContainer/Bottom/Attack.modulate = Color("#ff0000")




func die():
	"""
	Called when this creature die.
	The only way to queue_free()
	"""
	if is_self_side:
		die_effect()
	emit_signal("quit_battlefield")
	player.creature_died(create_drop_dico())
	queue_free()


# specific to creature
func create_attack_drag_clone():
	""" --> Control node
	Return the object created under the mouse when dragged
	"""
	
	var label = Label.new()
	label.text = "Attaquer" # just a label with a short descriptive text
	return label



# labels updaters for creature stats
func _on_Creature_attack_changed():
	update_labels()

func _on_Creature_pv_changed():
	update_labels()
	

# self drag&drop functions
func get_drag_data(_pos): # called when dragged
	if on_board:
		set_drag_preview(create_attack_drag_clone())
		
	else: # if the card is still in the hand
		set_drag_preview(create_play_drag_clone())
		
	return create_drop_dico()
		
		
func create_drop_dico():
	var has_defenseur = "Defenseur" in keywords or "Defenseur" in one_turn_keywords
	
	if on_board:
		return {"mana_cost": MANA_COST,"uniq_id": uniq_id,"drag_type":1, "card_name": node_name, "can_attack": can_attack and not has_defenseur, "attack_value": attack + one_turn_attack, "is_self_side": is_self_side}
	else:
		return {"mana_cost": MANA_COST,"uniq_id": uniq_id,"drag_type":0, "card_name": node_name, "can_attack": false, "attack_value": 0, "is_self_side": false}
# end


# Drop reception
func can_drop_data(_pos, card_dico):
	""" --> bool
	When a card is dragged on top of this creature this function is called.
	Return true if creature can be dropped for engage a fight, false if it can't, 
	depending on the turn and if the card as already attacked
	"""
	return (not is_self_side) and card_dico["is_self_side"] and card_dico["drag_type"]==global.ATTACK and card_dico["can_attack"] and player.your_turn 
	
	
func drop_data(_pos, other_creature_dico):
	"""
	Called when another creature is dragged on this creature
	"""
	player.fight_requested([create_drop_dico(), other_creature_dico]) # request a fight between this creature and the one who was dragged
# end
	
	
	
# signal implementation
func _on_self_tour_begin():
	"""
	Called when the tour begin
	Do some routine, like attack reset
	"""
	
	if is_self_side:
		can_attack = true
		guinsoo_available = true
		update_labels()
		tour_begin_effect()
	
	
func _on_self_end_of_turn():
	if is_self_side:
		end_turn_effect()
	
	
	
# fight functions
func _on_creature_attack_something(data):
	"""
	Called by the player when any creature attacks anything
	If the creature is self, do some can_attack set
	"""
	if data["uniq_id"] == uniq_id:
		#attack_effect()
		if ("Guinsoo" in keywords or "Guinsoo" in one_turn_keywords) and guinsoo_available:
			guinsoo_available = false
		else:
			can_attack = false
	
		update_labels()
		
func _on_creature_fight(data):
	_on_creature_attack_something(data[global.OPPONENT_CREATURE_DATA]) # return the other creature (I dont now why but it works)

func _on_Creature_pressed():
	# DEBUG
	#print("i am ",uniq_id)
	
	update_labels()
	
	# CHANGE THIS LATER
	if on_board:
		get_node("../../../../../").creature_pressed(uniq_id) # tell to the BattleScreen that this creature is pressed





"""
These are the functions which inherited creature will implement
"""
func tour_begin_effect():
	pass
	
func end_turn_effect():
	pass

func attack_effect():
	pass
	
func die_effect():
	pass
	
func enter_battlefield_effect():
	pass
