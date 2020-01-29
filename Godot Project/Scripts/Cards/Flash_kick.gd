extends "res://Scripts/Cards/Focus_Spell.gd"
tool

func _ready():
	node_name = "Flash_kick"

func apply_effect_to_creature(creature_id):
	player.kill_creature(creature_id) # kill the creature
	if player.uniq_ids_list[creature_id][player.SELF_SIDE]:
		player.add_card_to_hand(player.uniq_ids_list[creature_id][player.CREATURE_NAME])
	else:
		player.add_card_to_opponent_hand(player.uniq_ids_list[creature_id][player.CREATURE_NAME]) # put it to the opponent hand
