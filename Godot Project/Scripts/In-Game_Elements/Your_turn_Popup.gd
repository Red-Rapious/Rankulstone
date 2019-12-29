extends Popup

func _ready():
	player.connect("self_tour_begin", self, "_on_self_tour_begin")
	
func _on_self_tour_begin():
	popup()
	
	if options.options_dico["request_attention"]:
		OS.request_attention()
	create_timer()
	
	
func create_timer():
	"""
	To resolve a silly bug, the creature focus mode (bool) is going to be set to false
	only 0.5 seconds ater the popup is hiding.
	This timer is here for that.
	"""
	var timer = Timer.new()
	timer.name = "Timer"
	timer.connect("timeout",self,"_on_timer_timeout") 
	timer.set_wait_time(2)
	add_child(timer) #to process
	timer.start() #to start
	
func _on_timer_timeout():
	hide()