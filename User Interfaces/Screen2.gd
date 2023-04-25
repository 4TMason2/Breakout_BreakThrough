extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_SingleButton_pressed():
	Global.lives = Global.max_lives
	get_tree().change_scene("res://Levels/Level1.tscn")


func _on_MultiButton_pressed():
	get_tree().change_scene("res://User Interfaces/screen3.tscn")


func _on_BackButton_pressed():
	var options = load("res://User Interfaces/StartMenu.tscn").instance()
	get_tree().current_scene.add_child(options)