extends Control


func _process(delta):
	$Points.text = "Points: " + str(Global.points)
	


func _on_BackButton_pressed():
	get_tree().change_scene("res://User Interfaces/StartMenu.tscn")
