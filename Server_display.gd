extends Label

var ip_address = ""

func _on_Join_button_pressed():
	MultiplayerSetUp.ip_address = ip_address
	MultiplayerSetUp.connect_server()
	get_parent().get_parent().queue_free()
