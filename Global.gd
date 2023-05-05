extends Node

var max_lives = 3
var current_level = 1
var final_level = 5
var lives = max_lives
var hud # Pointer to the HUD
var num_bricks = 0
var bricks = []
var score = 0 setget set_score
var startM = 0
var typeM = -1 # 0 = original (coop), 1 = comp
var points = 0
# Dictionary 
var store = {
	'bought' : [true, false, false, false],
	'selected' : 0,
}
var save_store_path = 'user://save'

onready var ball = get_node_or_null("Ball")

signal level_loaded
signal score_updated

func _ready():
	connect("start_game",self,"load_level")

func count_bricks():
	num_bricks = 0
	bricks = []
	#print(num_bricks," before count")
	for brick in get_tree().get_nodes_in_group("Bricks"):
		bricks.append(brick)
		num_bricks += 1

	for brick in get_tree().get_nodes_in_group("spec_Bricks"):
		bricks.append(brick)
		num_bricks += 1	



func load_level(level_num):
	var level_path = "res://Levels/Level" + str(level_num) + ".tscn"
	Global.lives = Global.max_lives

	
	for node in get_tree().get_nodes_in_group("Powerups"):
		node.queue_free()
	
	get_tree().change_scene(level_path)
	
	if ball != null:
		ball.is_paused = true
	call_deferred("count_bricks")

func brick_break():
	num_bricks -= 1
	#print(num_bricks)
	if num_bricks == 0:
		current_level += 1
		
		# Go to win screen if on last level
		if current_level == final_level:
			win_game()
		else:
			load_level(current_level)


func win_game():
	get_tree().change_scene("res://User Interfaces/WinScreen.tscn")

func lose_life():
	lives -= 1
	if score >= 0:
		set_score(score - 10)
	hud.load_hearts()
	if lives <= 0:
		get_tree().change_scene("res://User Interfaces/GameOver.tscn")
		
func add_life():
	if lives < max_lives:
		lives += 1
		hud.load_hearts()

func reset():
	current_level = 1
	points = points + (score / 5)
	score = 0
	lives = max_lives
	save_store()

func set_score(value: int) -> void:
	score = value
	emit_signal("score_updated")



func instance_node_at_location(node: Object, parent: Object, location: Vector2) -> Object:
	var node_instance = instance_node(node, parent)
	node_instance.global_position = location
	return node_instance

func instance_node(node: Object, parent: Object) -> Object:
	var node_instance = node.instance()
	parent.add_child(node_instance)
	return node_instance



func save_store():
	var file = File.new()
	file.open(save_store_path,file.WRITE_READ)
	file.store_var(points)
	file.store_var(store)
	file.close()

func load_store():
	var file = File.new()
	if not file.file_exists(save_store_path):
		return false
	file.open(save_store_path,file.READ)
	points = file.get_var()
	store = file.get_var()
	file.close()
	return true



