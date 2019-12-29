extends VBoxContainer

signal pressed

func _ready():
	player.connect("self_mana_changed", self, "_on_self_mana_changed")
	player.connect("self_mana_max_changed", self, "_on_self_mana_changed")
	update_pseudo()
	update_icons()
	
func update_pseudo():
	$Pseudo.text = global.self_pseudo
	
func _on_self_mana_changed():
	$Mana_bar.text = "Mana : "+str(player.self_mana)+"/"+str(player.self_mana_max)
	
	$Mana_bar/ProgressBar.max_value = player.self_mana_max
	$Mana_bar/ProgressBar.value = player.self_mana

func update_icons():
	$TextureButton.texture_normal = load("res://Assets/Icons/"+str(global.self_icon)+".jpg")

func _on_TextureButton_pressed():
	emit_signal("pressed")
