extends VBoxContainer

func _ready():
	player.connect("opponent_mana_changed", self, "_on_opponent_mana_changed")
	player.connect("opponent_mana_max_changed", self, "_on_opponent_mana_changed")
	network.connect("network_infos_get", self, "_on_network_infos_get")
	_on_network_infos_get()
	
func _on_network_infos_get():
	$Pseudo.text = global.opponent_pseudo
	
func _on_opponent_mana_changed():
	$Mana_bar.text = "Mana : "+str(player.opponent_mana)+"/"+str(player.opponent_mana_max)