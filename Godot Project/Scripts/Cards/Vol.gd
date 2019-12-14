extends "res://Scripts/Cards/Focus_Spell.gd"
tool

func _ready():
	node_name = "Vol"

func apply_effect_to_creature(creature_id):
	player.kill_creature(creature_id) # kill the creature
	player.add_card_to_hand(player.uniq_ids_list[creature_id][player.CREATURE_NAME]) # put card into my hand
