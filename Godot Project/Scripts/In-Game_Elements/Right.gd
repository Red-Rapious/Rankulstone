extends VBoxContainer

func _ready():
	player.connect("self_library_changed", self, "_on_self_library_changed")
	player.connect("opponent_library_changed", self, "_on_opponent_library_changed")
	_on_self_library_changed() # initialize self hand
	_on_opponent_library_changed() # initialize the opponent hand
	
func _on_self_library_changed():
	$Self_Library.text = "Cartes restantes : "+str(len(player.library))
	
func _on_opponent_library_changed():
	$Opponent_Library.text = "Cartes restantes : "+str(player.opponent_library_size)