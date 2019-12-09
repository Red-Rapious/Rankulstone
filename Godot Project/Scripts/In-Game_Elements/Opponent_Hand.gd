extends HBoxContainer

func _ready():
	player.connect("opponent_hand_changed", self, "_on_opponent_hand_changed")
	update_hand()
	
func _on_opponent_hand_changed():
	update_hand()
	
func update_hand():
	clean_hand()
	load_opponent_hand()
	
func clean_hand():
	"""
	This function delete all nodes from the opponent's hand
	"""
	for node in get_children():
		remove_child(node)

func load_opponent_hand():
	"""
	This function look at player.hand, and add the specifics nodes to the Control hand
	"""
	var scene = load("res://Scenes/In-game-elements/Opponent_card.tscn")
	for card in range(player.opponent_hand_size):
		var scene_instance = scene.instance()
		add_child(scene_instance)