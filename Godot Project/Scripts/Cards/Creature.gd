extends TextureButton

export var pv_max = 1
export var attack = 1
var pv = pv_max

signal enter_battlefield
signal quit_battlefield

signal attack_changed
signal pv_changed
signal pv_max_changed

func set_attack(new_value: int):
	attack = new_value
	emit_signal("attack_changed")
	
func add_attack(value: int):
	attack += value
	emit_signal("attack_changed")
	
	
func set_pv(new_value: int):
	pv = new_value
	emit_signal("pv_changed")
	
func add_pv(value: int):
	pv += value
	if pv > pv_max:
		pv = pv_max
	emit_signal("pv_changed")
	
func set_pv_max(new_value: int):
	pv_max = new_value
	emit_signal("pv_max_changed")
	
func add_pv_max(value: int, fill=true):
	pv_max += value
	if fill:
		fill_pv()
		emit_signal("pv_changed")
	emit_signal("pv_max_changed")
	
func fill_pv():
	pv = pv_max


func _on_Creature_attack_changed():
	$VBoxContainer/Bottom/Attack.text = attack

func _on_Creature_pv_changed():
	$VBoxContainer/Bottom/PV.text = pv
