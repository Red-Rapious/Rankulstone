extends Label

func _ready():
	player.connect("opponent_hand_changed", self, "_on_opponent_hand_changed")
	
func _on_opponent_hand_changed():
	text = "Cartes ennemis : " + str(player.opponent_hand_size)
