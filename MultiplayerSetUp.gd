extends Node

const PORT = 28960

var ip_address = "127.0.0.1"
var server = null
var client = null
var master = 0
var player_instance = null
var player_instance2 = null
var ball = load("res://Objects/BallM.tscn")

func _ready() -> void:
	#for ip in IP.get_local_address():
	#	if ip.begins_with("192.168.") and not ip.ends_with(".1"):
	#		ip_address = ip
	
	get_tree().connect('connected_to_server', self, '_connected_to_server')
	get_tree().connect('server_disconnected', self, '_server_disconnected')


func create_server() -> void:
	server = NetworkedMultiplayerENet.new()
	server.create_server(PORT, 2)
	get_tree().set_network_peer(server)
	
	
func connect_server() -> void:
	client = NetworkedMultiplayerENet.new()
	client.create_client(ip_address, PORT)
	get_tree().set_network_peer(client)


func instance_player(id) -> void:
	var slider = null
	if Global.typeM == 0:
		slider = load("res://Objects/Slider1M.tscn")
		if master == 1:
			player_instance = Global.instance_node_at_location(slider, Players, Vector2(24, 300))
		else:
			player_instance = Global.instance_node_at_location(slider, Players, Vector2(952, 300))
		player_instance.name = str(id)
		player_instance.set_network_master(id)
		instance_ball(id)
	else:
		slider = load("res://Objects/Slider2M.tscn")
		if master == 1:
			player_instance = Global.instance_node_at_location(slider, Players, Vector2(256, 450))
		else:
			player_instance = Global.instance_node_at_location(slider, Players, Vector2(768, 496))
		player_instance.name = str(id)
		player_instance.set_network_master(id)
		instance_ball(id)
	
func instance_ball(id) -> void:
	if Global.typeM == 0:
		if master == 1:
			player_instance2 = Global.instance_node_at_location(ball, Players, Vector2(320, 300))
		else:
			player_instance2 = Global.instance_node_at_location(ball, Players, Vector2(660, 300))
		player_instance2.name = str(id)
		player_instance2.set_network_master(id)
	else: 
		if master == 1:
			player_instance2 = Global.instance_node_at_location(ball, Players, Vector2(256, 256))
		else:
			player_instance2 = Global.instance_node_at_location(ball, Players, Vector2(768, 256))
		player_instance2.name = str(id)
		player_instance2.set_network_master(id)

func reset_network_connection():
	if get_tree().has_network_peer():
		get_tree().network_peer = null
	get_tree().change_scene("res://User Interfaces/GameOver.tscn")

func _connected_to_server() -> void:
	print("Successfully connected to the server")
	
func _server_disconnected() -> void:
	print("Disconnected to the server")
	
	for child in Players.get_children():
		if child.is_in_group("Net"):
			child.queue_free()
	reset_network_connection()






