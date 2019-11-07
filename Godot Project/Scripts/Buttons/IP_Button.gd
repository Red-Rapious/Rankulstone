extends Button

var show_ip =  false

func _on_IP_Button_pressed():
	switch_text()
	
func switch_text():
	if show_ip:
		self.text = "Afficher mon adresse IP"
		show_ip = false
	else:
		self.text = IP.get_local_addresses()[1] + "  (cliquer pour cacher)"
		show_ip = true
