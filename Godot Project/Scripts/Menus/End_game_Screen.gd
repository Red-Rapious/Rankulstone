extends Control

func _ready():
	update()
	
func update():
	if global.last_game_result == global.OPP_SURREND:
		$VBoxContainer/Label.text = "VICTOIRE ! Vous avez gagné par forfait contre " + global.opponent_pseudo
	elif global.last_game_result == global.WIN:
		$VBoxContainer/Label.text = "VICTOIRE ! Vous avez gagné contre " + global.opponent_pseudo
	elif global.last_game_result == global.LOOSE:
		$VBoxContainer/Label.text = "DEFAITE... Vous avez perdu contre " + global.opponent_pseudo
	elif global.last_game_result == global.GAME_DECLINE:
		$VBoxContainer/Label.text = "PARTIE ANNULEE"
	elif global.last_game_result == global.VERSION_CONFLICT:
		$VBoxContainer/Label.text = "ERREUR - Les versions des deux joueurs sont incompatibles"
	
	"""else:
		# an error happend
		$VBoxContainer/Label.text = "--Error--"
	"""