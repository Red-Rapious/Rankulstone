extends TextureButton

export var icon_number = 0

func _ready():
	texture_normal = load("res://Assets/Icons/"+str(icon_number)+".jpg")

func _on_Icon_Button_pressed():
	get_node("../../../../").icon_pressed(icon_number)
