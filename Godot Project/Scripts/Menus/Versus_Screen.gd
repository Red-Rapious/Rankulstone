extends Control

const TIME_BEFORE_AUTO_DECLINE = 5
var time_remaining = TIME_BEFORE_AUTO_DECLINE
var have_made_a_choice

func _ready():
	network.connect("network_infos_get", self, "update_players_informations")
	update_players_informations()
	
	for i in range(TIME_BEFORE_AUTO_DECLINE):
		yield(get_tree().create_timer(1.0), "timeout") # wait 1.0 sec
		time_remaining -= 1
		$All/Buttons/Accept_Button.text = "Accepter le match  ("+str(time_remaining)+")"
		
	
	if not have_made_a_choice:
		network.set_self_accepted(false)
 
	
func update_players_informations():
	$All/Players/Self_Container/Pseudo.text = global.self_pseudo
	$All/Players/Opponent_Container/Pseudo.text = global.opponent_pseudo
	
	$All/Players/Self_Container/Icon_Texture.texture = load("res://Assets/Icons/"+str(global.self_icon)+".jpg")
	$All/Players/Opponent_Container/Icon_Texture.texture = load("res://Assets/Icons/"+str(global.opponent_icon)+".jpg")
	
	
func _on_Accept_Button_pressed():
	network.set_self_accepted(true)
	choice_made()
	

func _on_Decline_Button_pressed():
	network.set_self_accepted(false)
	choice_made()
	
func choice_made():
	$All/Buttons/Accept_Button.disabled = true
	$All/Buttons/Decline_Button.disabled = true
	have_made_a_choice = true