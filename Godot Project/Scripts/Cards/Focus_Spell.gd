extends "res://Scripts/Cards/Card.gd"
tool

func _ready():
	node_name = "Focus_Spell"
	type = FOCUS_SPELL

func play_card(id):
	"""
	Called when this card is played
	Do some routine
	"""
	#self.uniq_id = id
	#self.on_board = true
	self.emit_signal("played")
	
func apply_effect_to_creature(creature_id):
	pass

func is_target_ok(target_id):
	return true