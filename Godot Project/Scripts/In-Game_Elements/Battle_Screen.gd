extends Control

func _ready():
	#OS.window_fullscreen = true
	player.init()
	load_hand()
	
func _process(delta):
	if Input.is_action_pressed("ui_escape"):
		get_tree().quit()

func load_hand():
	for card in player.hand:
		var scene = load("res://Scenes/Cards/"+card+".tscn")
		var scene_instance = scene.instance()
		$All/Center/Self_Hand.add_child(scene_instance)

func _on_Board_card_dropped(node_name):
	play_card(node_name)
	
func play_card(node_name):
	var scene = load("res://Scenes/Cards/Card.tscn")
	var scene_instance = scene.instance()
	scene_instance.set_name("Card")
	scene_instance.play_card()
	
	get_node("All/Center/Self_Hand/"+node_name).queue_free()
	$All/Center/Board.add_child(scene_instance)
	
	player.card_played(get_node("All/Center/Self_Hand/"+node_name).NAME)
