extends Control


var server_ip_address = ''
var alreadyPressed = 0

onready var multiplayer_config_ui = $VBoxContainer
onready var device_ip_address = $CanvasLayer/Device_IP
onready var start_game = $CanvasLayer/Start

func _ready() -> void:
	get_tree().connect('network_peer_connected', self, '_player_connected')
	get_tree().connect('network_peer_disconnected', self, '_player_disconnected')
	get_tree().connect('connected_to_server', self, '_connected_to_server')
	
	#device_ip_address.text = MultiplayerSetUp.ip_address
	
	if get_tree().network_peer == null:
		start_game.hide()

func _process(_delta: float) -> void:
	if get_tree().network_peer != null:
		if get_tree().get_network_connected_peers().size() >= 1 and get_tree().is_network_server():
			start_game.show()
		else:
			start_game.hide()


func _player_connected(id) -> void:
	print("Player " + str(id) + " has connected")
	MultiplayerSetUp.instance_player(id)


func _player_disconnected(id) -> void:
	print("Player " + str(id) + " has disconnected")
	#if Players.has_node(str(id)):
	#	Players.get_node(str(id)).queue_free()



func _on_JoinButton_pressed():
	if alreadyPressed == 0:
		alreadyPressed = 1
		if server_ip_address != '':
			MultiplayerSetUp.ip_address = server_ip_address
		MultiplayerSetUp.connect_server()

func _on_CreateButton_pressed():
	if alreadyPressed == 0:
		MultiplayerSetUp.ip_address = server_ip_address
		print(MultiplayerSetUp.ip_address)
		alreadyPressed = 1
		MultiplayerSetUp.master = 1
		MultiplayerSetUp.create_server()
		MultiplayerSetUp.instance_player(get_tree().get_network_unique_id())
	

func _connected_to_server() -> void:
	yield(get_tree().create_timer(0.1), "timeout")
	MultiplayerSetUp.instance_player(get_tree().get_network_unique_id())



func _on_Server_IP_text_entered(new_text):
	server_ip_address = new_text


func _on_Start_pressed():
	rpc("switch_to_game")


sync func switch_to_game() -> void:
	Global.startM = 1
	if Global.typeM == 0:
		get_tree().change_scene("res://Levels/Multi1.tscn")
	else:
		get_tree().change_scene("res://Levels/Multi2.tscn")

func _on_BackButton_pressed():
	if alreadyPressed == 1:
		MultiplayerSetUp.server.close_connection()
		MultiplayerSetUp._server_disconnected()
	alreadyPressed = 0
	get_tree().change_scene("res://User Interfaces/Screen2.tscn")
