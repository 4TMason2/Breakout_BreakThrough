extends Control


signal start_game


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/StartButton.grab_focus()




func _on_StartButton_pressed():
	Global.lives = Global.max_lives
	get_tree().change_scene("res://Levels/Level1.tscn")
	emit_signal("start_game")
	


func _on_OptionsButton_pressed():
	var options = load("res://User Interfaces/Options.tscn").instance()
	get_tree().current_scene.add_child(options)


func _on_QuitButton_pressed():
	get_tree().quit()
	
