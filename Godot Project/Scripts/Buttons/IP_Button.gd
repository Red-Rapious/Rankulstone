extends CanvasLayer

var doShowIp = false

func _on_IP_Button_pressed():
	if (doShowIp):
		$IP_Button.text = "test"
	else:
		$HTTPRequest.request("https://api.myip.com")
	
	doShowIp = !doShowIp

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	
	if (response_code == 200):
		$IP_Button.text = JSON.parse(body.get_string_from_utf8()).result["ip"]
	else:
		$IP_Button.text = "Could Resolve Ip"