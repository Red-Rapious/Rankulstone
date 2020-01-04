extends "res://Scripts/Cards/Card.gd"

export var turns_before_effect = 0

func _ready():
	type = SPELL

func play_card(id):
	"""
	Called when this card is played
	Do some routine
	"""
	#self.uniq_id = id
	#self.on_board = true
	self.emit_signal("played")
	apply_effect()
	
func apply_effect():
	pass