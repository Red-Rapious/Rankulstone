extends Control

func _ready():
	update()
	
func update():
	if global.win:
		$VBoxContainer/Label.text = "VICTOIRE ! Vous avez gagné contre " + global.opponent_pseudo
	else:
		$VBoxContainer/Label.text = "DEFAITE... Vous avez perdu contre " + global.opponent_pseudo