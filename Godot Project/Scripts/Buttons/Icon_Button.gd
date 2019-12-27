extends TextureButton

export var icon_number = 0
var is_selected = false

func _ready():
	texture_normal = load("res://Assets/Icons/"+str(icon_number)+".jpg")
	update_border()

func _on_Icon_Button_pressed():
	get_node("../../../../").icon_pressed(icon_number)
	
func set_select(selection: bool):
	is_selected = selection
	update_border()
	
func update_border():
	if is_selected:
		$TextureRect.visible = true
	else:
		$TextureRect.visible = false
