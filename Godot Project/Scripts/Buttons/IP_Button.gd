extends Control

var doShowIp = false
var ip

func _ready():
	$HTTPRequest.request("https://api.myip.com")

func _on_IP_Button_pressed():
	if (doShowIp):
		$IP_Button.text = "test"
	else:
		$IP_Button.text = ip
	
	doShowIp = !doShowIp

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	
	if (response_code == 200):
		ip = JSON.parse(body.get_string_from_utf8()).result["ip"]
	else:
		ip = "Couldn't Resolve Ip"

func _on_Button_pressed():
	OS.set_clipboard(ip)
