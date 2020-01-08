extends "res://Scripts/Cards/Spell.gd"
tool

const OPPONENT = -1
const SELF = -2

func _ready():
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