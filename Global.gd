extends Node

var max_lives = 3
var current_level = 1
var lives = max_lives
var hud # Pointer to the HUD
var num_bricks = 0
var bricks = []
signal level_loaded
var startM = 0
var typeM = 0

func _ready():
	connect("start_game",self,"load_level")
	
	

func count_bricks():
	num_bricks = 0
	bricks = []
	#print(num_bricks," before count")
	for brick in get_tree().get_nodes_in_group("Bricks"):
		bricks.append(brick)
		num_bricks += 1
	#print(num_bricks," counted")
	#print(bricks)


func load_level(level_num):
	var level_path = "res://Levels/Level" + str(level_num) + ".tscn"
	Global.lives = Global.max_lives
	#print("Loading level: ", level_path)
	get_tree().change_scene(level_path)
	call_deferred("count_bricks")

func brick_break():
	num_bricks -= 1
	#print(num_bricks)
	if num_bricks == 0:
		current_level += 1
		load_level(current_level)

func lose_life():
	lives -= 1
	hud.load_hearts()
	if lives <= 0:
		get_tree().change_scene("res://User Interfaces/GameOver.tscn")

func instance_node_at_location(node: Object, parent: Object, location: Vector2) -> Object:
	var node_instance = instance_node(node, parent)
	node_instance.global_position = location
	return node_instance

func instance_node(node: Object, parent: Object) -> Object:
	var node_instance = node.instance()
	parent.add_child(node_instance)
	return node_instance





