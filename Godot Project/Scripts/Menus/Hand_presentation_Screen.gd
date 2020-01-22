extends Control

const TIME_BEFORE_LAUNCH = 5
var time_reamining = TIME_BEFORE_LAUNCH

func _ready():
	#player.init()
	player.draw_new_hand()
	player.connect("self_hand_changed", self, "update_hand")
	update_hand()
	
	for i in range(TIME_BEFORE_LAUNCH):
		yield(get_tree().create_timer(1.0), "timeout") # wait 1.0 sec
		time_reamining -= 1
		
		$All/Label.text = "Votre main :\n("+str(time_reamining)+")"
		
	get_tree().change_scene("Scenes/Battle_Screen.tscn")

func update_hand():
	for card in $All/Hand_Container.get_children():
		card.queue_free()
		
	for card in player.hand:
		var scene = load("res://Scenes/Cards/"+card+".tscn")
		var scene_instance = scene.instance()
		$All/Hand_Container.add_child(scene_instance)