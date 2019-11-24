extends VBoxContainer

func _ready():
	player.connect("self_mana_changed", self, "_on_self_mana_changed")
	player.connect("self_mana_max_changed", self, "_on_self_mana_changed")
	player.connect("opponent_mana_changed", self, "_on_opponent_mana_changed")
	player.connect("opponent_mana_max_changed", self, "_on_opponent_mana_changed")
	network.connect("network_infos_get", self, "_on_network_infos_get")
	_on_network_infos_get()
	
func _on_self_mana_changed():
	$Self/Self_Mana_bar.text = "Mana : "+str(player.self_mana)+"/"+str(player.self_mana_max)
	
func _on_opponent_mana_changed():
	$Opponent/Opponent_Mana_bar.text = "Mana : "+str(player.opponent_mana)+"/"+str(player.opponent_mana_max)
	
func _on_network_infos_get():
	$Opponent/Pseudo.text = global.opponent_pseudo
	$Self/Pseudo.text = global.self_pseudo