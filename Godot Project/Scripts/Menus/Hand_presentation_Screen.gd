extends Control

const TIME_BEFORE_LAUNCH = 8
var time_remaining = TIME_BEFORE_LAUNCH

func _ready():
	player.connect("self_hand_changed", self, "update_hand")
	player.init_hand()
	update_hand()
	
	if network.is_start_first:
		$All/Top/Labels/Who_start_Label.text = "Vous commencez"
	else:
		$All/Top/Labels/Who_start_Label.text = "L'adversaire commence"
	
	for i in range(TIME_BEFORE_LAUNCH):
		yield(get_tree().create_timer(1.0), "timeout") # wait 1.0 sec
		time_remaining -= 1
		
		$All/Top/Timer.text = str(time_remaining)
		
	get_tree().change_scene("Scenes/Battle_Screen.tscn")

func update_hand():
	for card in $All/Hand_Container.get_children():
		card.queue_free()
		
	for card in player.hand:
		var scene = load("res://Scenes/Cards/"+card+".tscn")
		var scene_instance = scene.instance()
		$All/Hand_Container.add_child(scene_instance)

func _on_Keep_pressed():
	pass # disabled for now

func _on_Muligan_pressed():
	player.init_hand()
	$All/Buttons_Container/Muligan.disabled = true
