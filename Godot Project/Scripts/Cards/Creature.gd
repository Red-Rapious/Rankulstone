extends "res://Scripts/Cards/Card.gd"
tool

var on_board = false
var is_self_side
var can_attack = false # attack is false by default to simulate invocation sickness

export var pv = 1
export var attack = 1
export var keywords = [] # Alpha, Guinsoo...
var pv_max = pv


# keywords
var guinsoo_available = true


signal enter_battlefield
signal quit_battlefield

signal attack_changed
signal pv_changed
signal pv_max_changed



func _ready():
	type = CREATURE
	node_name = NAME
	player.connect("self_tour_begin", self, "_on_self_tour_begin")
	player.connect("self_creature_attack_opponent", self, "_on_creature_attack_something")
	player.connect("self_creature_fight", self, "_on_creature_fight")
	
	if "Alpha" in keywords:
		can_attack = true # disable invocation sickness
		
	update_labels()
	pv_max = pv
	check_pv()



# some attacks setters
func set_attack(new_value: int):
	attack = new_value
	emit_signal("attack_changed")
	
func add_attack(value: int):
	attack += value
	emit_signal("attack_changed")
	
	
# some pv & pv_max setters
func set_pv(new_value: int):
	pv = new_value
	check_pv()
	emit_signal("pv_changed")
	
func add_pv(value: int):
	set_pv(pv + value)
	
	
	
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




func play_card(id):
	"""
	Called when this card is played
	Do some routine
	"""
	
	uniq_id = id
	name = str(uniq_id)
	on_board = true
	enter_battlefield_effect()
	emit_signal("played")
	
	
func update_labels():
	""" 
	See Card.update_labels
	"""
	$VBoxContainer/Top/Name.text = NAME
	
	if on_board: # if on board, dont show mana cost
		$VBoxContainer/Top/Mana_cost.text = ""
	else:
		$VBoxContainer/Top/Mana_cost.text = str(MANA_COST)
		
	$VBoxContainer/Action_Text.text = ""
	#$VBoxContainer/Under_text.text = UNDER_TEXT
	$VBoxContainer/Under_text.text = ""
	$VBoxContainer/Bottom/PV.text = str(pv)
	$VBoxContainer/Bottom/Attack.text = str(attack)



func die():
	"""
	Called when this creature die.
	The only way to queue_free()
	"""
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
	

# drag&drop functions
func get_drag_data(_pos): # called when dragged
	if on_board:
		set_drag_preview(create_attack_drag_clone())
		
	else: # if the card is still in the hand
		set_drag_preview(create_play_drag_clone())
	return create_drop_dico()
		
		
func create_drop_dico():
	if on_board:
		#return {"uniq_id": uniq_id,"drag_type":1, "card_name": NAME, "node_name": name, "can_attack": can_attack, "attack_value": attack, "is_self_side": is_self_side}
		return {"mana_cost": MANA_COST,"uniq_id": uniq_id,"drag_type":1, "card_name": node_name, "can_attack": can_attack, "attack_value": attack, "is_self_side": is_self_side}
	else:
		#return {"uniq_id": uniq_id,"drag_type":0, "card_name": NAME, "node_name": name, "can_attack": false, "attack_value": 0, "is_self_side": false}
		return {"mana_cost": MANA_COST,"uniq_id": uniq_id,"drag_type":0, "card_name": node_name, "can_attack": false, "attack_value": 0, "is_self_side": false}

func can_drop_data(_pos, card_dico):
	""" --> bool
	When a card is dragged on top of a creature this function is called.
	Return true if creature can be dropped for engage a fight, false if it can't, 
	depending on the turn and if the card as already attacked
	"""
	return (not is_self_side) and card_dico["is_self_side"] and card_dico["drag_type"]==global.ATTACK and card_dico["can_attack"] and player.your_turn 
	
func drop_data(_pos, other_creature_dico):
	"""
	Called when another creature is dragged on this creature
	"""
	player.fight_requested([create_drop_dico(), other_creature_dico]) # request a fight between this creature and the one who was dragged
	
	
	
	
# signal implementation
func _on_self_tour_begin():
	"""
	Called when the tour begin
	Do some routine, like attack reset
	"""
	can_attack = true
	guinsoo_available = true
	tour_begin_effect()
	
	
	
# fight functions
func _on_creature_attack_something(data):
	"""
	Called by the player when any creature attacks anything
	If the creature is self, do some can_attack set
	"""
	if data["uniq_id"] == uniq_id:
		attack_effect()
		if "Guinsoo" in keywords and guinsoo_available:
			guinsoo_available = false
		else:
			can_attack = false
		
func _on_creature_fight(data):
	_on_creature_attack_something(data[global.OPPONENT_CREATURE_DATA]) # return the other creature (I dont now why but it works)

func _on_Creature_pressed():
	# CHANGE THIS LATER
	if on_board:
		get_node("../../../../../").creature_pressed(uniq_id) # tell to the BattleScreen that this creature is pressed



"""
These are the functions which inherited creature will implement
"""

func tour_begin_effect():
	pass

func attack_effect():
	pass
	
func die_effect():
	pass
	
func enter_battlefield_effect():
	pass