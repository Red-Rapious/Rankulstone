extends "res://Scripts/Cards/Focus_Spell.gd"

func _ready():
	node_name = "Range_top"

func is_target_ok(target_id):
	# target is ok if the creature as tribe "Miko"
	
	# instance a card
	var scene = load("res://Scenes/Cards/"+player.uniq_ids_list[target_id][player.CREATURE_NAME]+".tscn")
	var instance = scene.instance()
	
	return "Miko" in instance.tribe # is "Miko" in the basic card tribe ?

func apply_effect_to_creature(creature_id):
	player.kill_creature(creature_id) # kill the creature