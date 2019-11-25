extends "res://Scripts/Cards/Card.gd"
tool

var on_board = false
var is_self_side
var can_attack = true

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
	
	
func check_pv(): # a function that checks if pv is under 0
	if pv<0:
		pass # dont do anything for now
		
func die():
	emit_signal("quit_battlefield")
	queue_free()

func create_attack_drag_clone():
	""" --> Control node
	Return the object created under the mouse when dragged
	"""
	
	var label = Label.new()
	label.text = "Attaquer" # just a label with a short descriptive text
	return label

# some labels updaters for creature stat
func _on_Creature_attack_changed():
	$VBoxContainer/Bottom/Attack.text = attack

func _on_Creature_pv_changed():
	$VBoxContainer/Bottom/PV.text = pv
	
	
	
func get_drag_data(_pos): # called when dragged
	if on_board:
		set_drag_preview(create_attack_drag_clone())
		return [1,NAME, name, can_attack, attack]
		
	else:
		set_drag_preview(create_play_drag_clone())
		# return card name
		return [0,NAME,name,false, 0]
		
func _on_self_tour_begin():
	"""
	Called when the tour begin
	Do some routine, like attack reset
	"""
	can_attack = true