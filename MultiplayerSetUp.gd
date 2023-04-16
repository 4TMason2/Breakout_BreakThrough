extends Node

const PORT = 28960

var ip_address = "127.0.0.1"
var server = null
var client = null

func _ready() -> void:
	#for ip in IP.get_local_address():
	#	if ip.begins_with("192.168.") and not ip.ends_with(".1"):
	#		ip_address = ip
	
	get_tree().connect('connected_to_server', self, '_connected_to_server')
	get_tree().connect('server_disconnected', self, '_server_disconnected')


func create_server() -> void:
	server = NetworkedMultiplayerENet.new()
	server.create_server(PORT, 5)
	get_tree().set_network_peer(server)
	
	
func connect_server() -> void:
	client = NetworkedMultiplayerENet.new()
	client.create_client(ip_address, PORT)
	get_tree().set_network_peer(client)



func _connected_to_server() -> void:
	print("Successfully connected to the server")
	
func _server_disconnected() -> void:
	print("Disconnected to the server")







