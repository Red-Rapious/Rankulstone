extends Popup

var remaining_cards = []

func _ready():
	player.connect("opponent_card_played_from_hand", self, "_on_opponent_card_played_from_hand")

func _on_opponent_card_played_from_hand(card_name):
	remaining_cards.append(card_name)
	if not visible:
		popup()
	

func _on_Opponent_card_Popup_about_to_show():
	for i in $All.get_children():
		if not i is Label:
			i.queue_free()
			
	var scene = load("res://Scenes/Cards/"+remaining_cards[0]+".tscn")
	var instance = scene.instance()
	$All.add_child(instance)
	remaining_cards.remove(0)

func _on_Opponent_card_Popup_popup_hide():
	if remaining_cards != []:
		popup()
