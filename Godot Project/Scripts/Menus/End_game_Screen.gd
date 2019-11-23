extends Control

func _ready():
	update()
	
func update():
	if global.win:
		$VBoxContainer/Label.text = "Victoire !"
	else:
		$VBoxContainer/Label.text = "Défaite..."