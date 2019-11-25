extends VBoxContainer

func _ready():
	player.connect("self_mana_changed", self, "_on_self_mana_changed")
	player.connect("self_mana_max_changed", self, "_on_self_mana_changed")
	update_pseudo()
	
func update_pseudo():
	$Pseudo.text = global.self_pseudo
	
func _on_self_mana_changed():
	$Mana_bar.text = "Mana : "+str(player.self_mana)+"/"+str(player.self_mana_max)
