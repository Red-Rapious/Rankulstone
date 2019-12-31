extends "res://Scripts/Cards/Focus_Spell.gd"
tool

# creature gain +2/+0 and Indestructible until end of turn

func _ready():
	node_name = "Rage"

func apply_effect_to_creature(creature_id):
	pass

func is_target_ok(target_id):
	return target_id >= 0 # only focus creatures
