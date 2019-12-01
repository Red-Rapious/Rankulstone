extends "res://Scripts/Cards/Card.gd"
tool

var on_board = false
var is_self_side
var can_attack = false # attack is false by default to simulate invocation sickness

export var pv_max = 1
export var attack = 1
var pv = pv_max

signal enter_battlefield
signal quit_battlefield

signal attack_changed
signal pv_changed
signal pv_max_changed



func _ready():
	player.connect("self_tour_begin", self, "_on_self_tour_begin")
	player.connect("self_creature_attack_opponent", self, "_on_creature_attack_something")
	player.connect("self_creature_fight", self, "_on_creature_fight")



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
	emit_signal("pv_changed")
	
func add_pv(value: int):
	pv += value
	if pv > pv_max:
		pv = pv_max
	emit_signal("pv_changed")
	
func set_pv_max(new_value: int):
	pv_max = new_value
	emit_signal("pv_max_changed")
	
func add_pv_max(value: int, fill=true):
	pv_max += value
	if fill:
		fill_pv()
		emit_signal("pv_changed")
	emit_signal("pv_max_changed")
	
func fill_pv():
	pv = pv_max
	

func play_card():
	"""
	Called when this card is played
	Do some routine
	"""
	self.on_board = true
	self.emit_signal("played")
	
func update_labels():
	$VBoxContainer/Top/Name.text = NAME
	if on_board:
		$VBoxContainer/Top/Mana_cost.text = ""
	else:
		$VBoxContainer/Top/Mana_cost.text = str(MANA_COST)
	$VBoxContainer/Action_Text.text = ""
	#$VBoxContainer/Under_text.text = UNDER_TEXT
	$VBoxContainer/Under_text.text = ""

# some die functions
func check_pv(): # a function that checks if pv is under 0
	if pv<=0:
		die() # dont do anything for now
		
func die():
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
	$VBoxContainer/Bottom/Attack.text = str(attack)

func _on_Creature_pv_changed():
	check_pv()
	$VBoxContainer/Bottom/PV.text = str(pv)
	
	

func get_drag_data(_pos): # called when dragged
	if on_board:
		set_drag_preview(create_attack_drag_clone())
		
	else: # if the card is still in the hand
		set_drag_preview(create_play_drag_clone())
	return create_drop_dico()
		
		
func create_drop_dico():
	if on_board:
		return {"drag_type":1, "card_name": NAME, "node_name": name, "can_attack": can_attack, "attack_value": attack, "is_self_side": is_self_side}
	else:
		return {"drag_type":0, "card_name": NAME, "node_name": name, "can_attack": false, "attack_value": 0, "is_self_side": false}
		
# signals implementation
func _on_self_tour_begin():
	"""
	Called when the tour begin
	Do some routine, like attack reset
	"""
	can_attack = true
	
	
	
func can_drop_data(_pos, data):
	""" --> bool
	When a card is dragged on top of the opponent UI group, this function is called.
	Return true if item can be dropped, false if it can't, 
	depending on the turn and if the card as already attacked
	"""
	return (not is_self_side) and data["is_self_side"] and data["drag_type"]==global.ATTACK and data["can_attack"] and player.your_turn 
	
func drop_data(_pos, data):
	player.fight_requested([create_drop_dico(), data])
	
func _on_creature_attack_something(data):
	if data["node_name"] == name and data["is_self_side"] == is_self_side: # if the creature who attacks is me
		can_attack = false
		
func _on_creature_fight(data):
	_on_creature_attack_something(data[global.SELF_CREATURE_DATA])