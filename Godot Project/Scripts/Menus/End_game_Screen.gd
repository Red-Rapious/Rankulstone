extends Control

func _ready():
	update()
	
func update():
	if global.opponent_surrend:
		$VBoxContainer/Label.text = "VICTOIRE ! Vous avez gagné par forfait contre " + global.opponent_pseudo
	elif global.win:
		$VBoxContainer/Label.text = "VICTOIRE ! Vous avez gagné contre " + global.opponent_pseudo
	else:
		$VBoxContainer/Label.text = "DEFAITE... Vous avez perdu contre " + global.opponent_pseudo
	
	"""else:
		# an error happend
		$VBoxContainer/Label.text = "--Error--"
	"""