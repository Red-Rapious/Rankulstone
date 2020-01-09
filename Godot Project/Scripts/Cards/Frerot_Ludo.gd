extends "res://Scripts/Cards/Creature.gd"
tool


func _ready():
	node_name = "Frerot_Ludo"
	

func die_effect():
	for creature in get_tree().get_current_scene().get_node("All/Center/Board/Self_Board").get_children():
		if creature.node_name == "Grosse_Berta":
			player.kill_creature(creature.uniq_id)
			break
