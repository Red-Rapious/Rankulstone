extends Control

func _ready():
	OS.window_fullscreen = true
	
func _process(delta):
	if Input.is_action_pressed("ui_escape"):
		get_tree().quit()

func _on_Board_card_dropped(node_name):
	var scene = load("res://Scenes/Cards/Board_Card.tscn")
	var scene_instance = scene.instance()
	scene_instance.set_name("Board_card")
	
	get_node("All/Center/Self_Hand/"+node_name).queue_free()
	$All/Center/Board.add_child(scene_instance)