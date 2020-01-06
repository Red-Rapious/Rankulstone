extends "res://Scripts/Cards/Spell.gd"
tool

func _ready():
	node_name = "Mme_Jean"


func apply_effect():
		
	for creature in player.get_tree().get_current_scene().get_node("All/Center/Board/Opponent_Board").get_children():
		player.add_one_turn_keyword(creature.uniq_id, "Defenseur")