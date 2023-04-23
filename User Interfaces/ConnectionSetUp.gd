extends Control

var slider = load("res://Objects/Slider1M.tscn")
var ball = load("res://Objects/BallM.tscn")
var server_ip_address = ''
var master = 0

onready var multiplayer_config_ui = $VBoxContainer
onready var device_ip_address = $CanvasLayer/Device_IP
onready var start_game = $CanvasLayer/Start

func _ready() -> void:
	get_tree().connect('network_peer_connected', self, '_player_connected')
	get_tree().connect('network_peer_disconnected', self, '_player_disconnected')
	get_tree().connect('connected_to_server', self, '_connected_to_server')
	
	device_ip_address.text = MultiplayerSetUp.ip_address
	
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
	instance_player(id)


func _player_disconnected(id) -> void:
	print("Player " + str(id) + " has disconnected")
	#if Players.has_node(str(id)):
	#	Players.get_node(str(id)).queue_free()



func _on_JoinButton_pressed():
	#if server_ip_address != '':
		#MultiplayerSetUp.ip_address = server_ip_address
		MultiplayerSetUp.connect_server()

func _on_CreateButton_pressed():
	master = 1
	MultiplayerSetUp.create_server()
	instance_player(get_tree().get_network_unique_id())
	

func _connected_to_server() -> void:
	yield(get_tree().create_timer(0.1), "timeout")
	instance_player(get_tree().get_network_unique_id())


func instance_player(id) -> void:
	var player_instance = null
	var player_instance2 = null
	if master == 1:
		player_instance = Global.instance_node_at_location(slider, Players, Vector2(24, 300))
		player_instance2 = Global.instance_node_at_location(ball, Players, Vector2(320, 300))
	else:
		player_instance = Global.instance_node_at_location(slider, Players, Vector2(952, 300))
		player_instance2 = Global.instance_node_at_location(ball, Players, Vector2(660, 300))
	player_instance.name = str(id)
	player_instance.set_network_master(id)
	player_instance2.name = str(id)
	player_instance2.set_network_master(id)


func _on_Server_IP_text_entered(new_text):
	server_ip_address = new_text


func _on_Start_pressed():
	rpc("switch_to_game")


sync func switch_to_game() -> void:
	get_tree().change_scene("res://Levels/Multi1.tscn")





