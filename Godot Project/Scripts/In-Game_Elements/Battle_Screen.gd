extends Control

func _ready():
	player.connect("opponent_creature_played", self, "_on_opponent_creature_played")
	player.connect("self_hand_changed", self, "_on_self_hand_changed")
	#OS.window_fullscreen = true
	player.init()
	_on_self_hand_changed()
	
func _process(delta):
	# quit game if escape is pressed
	if Input.is_action_pressed("ui_escape"):
		get_tree().quit()


# some hand interactions methods
func load_hand():
	"""
	This function look at player.hand, and add the specifics nodes to the Control hand
	"""
	for card in player.hand:
		var scene = load("res://Scenes/Cards/"+card+".tscn")
		var scene_instance = scene.instance()
		$All/Center/Self_Hand.add_child(scene_instance)
		
func clean_hand():
	"""
	This function delete all nodes from the player's hand
	"""
	for node in $All/Center/Self_Hand.get_children():
		$All/Center/Self_Hand.remove_child(node)

func _on_self_hand_changed():
	# reset hand, by cleaning all and reloading the whole hand
	clean_hand()
	load_hand()



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
	scene_instance.is_self_side = self_side
	
	# add instance to the board
	if self_side:
		$All/Center/Board/Self_Board.add_child(scene_instance)
	else:
		$All/Center/Board/Opponent_Board.add_child(scene_instance)
		
	

func play_card_from_hand(node_name: String):
	"""
	A function that :
		- delete a node card in the hand to reinstance it on the board if its a creature
		- launch the spell if its a spell
	"""
	
	var card=get_node("All/Center/Self_Hand/"+node_name)
	
	# delete hand card
	if card.type == card.CREATURE:
		get_node("All/Center/Self_Hand/"+node_name).queue_free()
		add_card_to_board(true,card.NAME)
		player.card_played_from_hand(card.NAME, card.MANA_COST)
	else:
		# TODO : launch the spell
		pass

func _on_opponent_creature_played(card_name):
	"""
	Called when the opponent plays a card
	Simply add the card to the board
	"""
	add_card_to_board(false, card_name) # "false" to put in the opponent side

func _on_Opponent_card_attacked(data):
	"""
	Called when you attack the opponent with a card
	Inform player.gd and change can_attack on the card, so it cant attack twice
	"""
	player.self_card_attack_opponent(data[global.ATTACK_VALUE]) # inform player
	get_node("All/Center/Board/Self_Board/"+data[global.NODE_NAME]).can_attack = false # block a second attempt
	pass
