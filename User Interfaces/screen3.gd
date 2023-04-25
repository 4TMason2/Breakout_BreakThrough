extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _on_CoopButton_pressed():
	Global.typeM = 0
	get_tree().change_scene("res://User Interfaces/ConnectionSetUp.tscn")

func _on_CompButton_pressed():
	Global.typeM = 1
	get_tree().change_scene("res://User Interfaces/ConnectionSetUp.tscn")
	


func _on_BackButton_pressed():
	get_tree().change_scene("res://User Interfaces/screen2.tscn")
