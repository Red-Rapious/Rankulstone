extends Control

func _ready():
	#OS.window_fullscreen = true
	player.init()
	load_hand()
	
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
	play_card(node_name)
	
func play_card(node_name: String):
	"""
	A function that delete a node in the hand to reinstance it on the board
	"""
	
	# instance
	var scene = load("res://Scenes/Cards/Card.tscn")
	var scene_instance = scene.instance()
	scene_instance.set_name("Card")
	scene_instance.play_card()
	
	# delete hand card
	get_node("All/Center/Self_Hand/"+node_name).queue_free()
	# add instance to the board
	$All/Center/Board.add_child(scene_instance)
	player.card_played(get_node("All/Center/Self_Hand/"+node_name).NAME)
