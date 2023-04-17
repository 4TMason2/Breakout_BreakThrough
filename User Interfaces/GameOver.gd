extends Control

onready var score: Label = get_node("VBoxContainer/Score")

func _ready():
	score.text = score.text % Global.score

func _on_ContiueButton_pressed():
	Global.reset()
	get_tree().change_scene("res://Levels/Level1.tscn")


func _on_MainMenu_pressed():
	get_tree().change_scene("res://User Interfaces/StartMenu.tscn")
