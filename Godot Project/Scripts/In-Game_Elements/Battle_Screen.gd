extends Control

func _ready():
	player.connect("opponent_board_changed", self, "_on_opponent_board_changed")
	player.connect("self_hand_changed", self, "_on_self_hand_changed")
	#OS.window_fullscreen = true
	player.init()
	_on_self_hand_changed()
	
func _process(delta):
	if Input.is_action_pressed("ui_escape"):
		get_tree().quit()

func load_hand():
	"""
	This function look at player.hand, and add the specifics nodes to the Control hand
	"""
	for card in player.hand:
		var scene = load("res://Scenes/Cards/"+card+".tscn")
		var scene_instance = scene.instance()
		$All/Center/Self_Hand.add_child(scene_instance)

func _on_Board_card_dropped(node_name):
	play_card_from_hand(node_name)
	
func add_card_to_board(self_side, card_name):
	"""
	A function that add a card to the board. If self_side is true, add it to your own hand.
	Else, add it to the opponent hand
	"""
	
	# instance card
	var scene = load("res://Scenes/Cards/"+card_name+".tscn")
	var scene_instance = scene.instance()
	scene_instance.play_card()
	
	# add instance to the board
	if self_side:
		$All/Center/Board/Self_Board.add_child(scene_instance)
	else:
		$All/Center/Board/Opponent_Board.add_child(scene_instance)
	
func _on_self_hand_changed():
	for node in $All/Center/Self_Hand.get_children():
		$All/Center/Self_Hand.remove_child(node)
	load_hand()
	
func play_card_from_hand(node_name: String):
	"""
	A function that delete a node in the hand to reinstance it on the board
	"""
	
	var card=get_node("All/Center/Self_Hand/"+node_name)
	
	# delete hand card
	get_node("All/Center/Self_Hand/"+node_name).queue_free()
	add_card_to_board(true,card.NAME)
	player.card_played_from_hand(card.NAME)

func _on_opponent_board_changed(card_name):
	add_card_to_board(false, card_name)