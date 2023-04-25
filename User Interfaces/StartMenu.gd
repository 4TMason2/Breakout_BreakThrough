extends Control


signal start_game


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/StartButton.grab_focus()



func _on_StartButton_pressed():
	var options = load("res://User Interfaces/Screen2.tscn").instance()
	get_tree().current_scene.add_child(options)
	


func _on_ShopButton_pressed():
	get_tree().change_scene("res://User Interfaces/Shop.tscn")


func _on_QuitButton_pressed():
	get_tree().quit()
	
