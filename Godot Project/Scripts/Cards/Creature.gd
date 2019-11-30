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
	


# some die functions
func check_pv(): # a function that checks if pv is under 0
	if pv<0:
		pass # dont do anything for now
		
func die():
	emit_signal("quit_battlefield")
	player.creature_died(name)
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
	$VBoxContainer/Bottom/Attack.text = attack

func _on_Creature_pv_changed():
	$VBoxContainer/Bottom/PV.text = pv
	
	

func get_drag_data(_pos): # called when dragged
	if on_board:
		set_drag_preview(create_attack_drag_clone())
		#return [1,NAME, name, can_attack, attack, is_self_side]
		
	else: # if the card is still in the hand
		set_drag_preview(create_play_drag_clone())
		# return card name
		#return [0,NAME,name,false, 0, false]
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