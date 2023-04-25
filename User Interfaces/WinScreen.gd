extends Control

onready var score: Label = get_node("VBoxContainer/Score")

func _ready():
	Global.connect("score_updated",self,"update_interface")
	update_interface()
	
func update_interface():
	score.text = score.text % Global.score

func _on_MainMenu_pressed():
	Global.reset()
	get_tree().change_scene("res://User Interfaces/StartMenu.tscn")


func _on_Credits_pressed():
	Global.reset()
	get_tree().change_scene("res://User Interfaces/GodotCredits.tscn")
