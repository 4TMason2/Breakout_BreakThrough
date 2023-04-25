extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _on_CoopButton_pressed():
	Global.typeM = 0
	var options = load("res://User Interfaces/ConnectionSetUp.tscn").instance()
	get_tree().current_scene.add_child(options)

func _on_CompButton_pressed():
	Global.typeM = 1
	var options = load("res://User Interfaces/ConnectionSetUp.tscn").instance()
	get_tree().current_scene.add_child(options)


func _on_BackButton_pressed():
	var options = load("res://User Interfaces/Screen2.tscn").instance()
	get_tree().current_scene.add_child(options)
