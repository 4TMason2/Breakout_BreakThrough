extends Control

var is_paused = false setget set_is_paused


func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		self.is_paused = !is_paused
		get_tree().set_input_as_handled()

func set_is_paused(value):
	is_paused = value
	get_tree().paused = is_paused
	visible = is_paused

func _on_ResumeButton_pressed():
	self.is_paused = false

func _on_QuitButton_pressed():
	self.is_paused = false
	get_tree().quit()

func _on_MainMenuButton_pressed():
	self.is_paused = false
	if Global.typeM > -1:
		Global.typeM = -1
		for child in Players.get_children():
			if child.is_in_group("Net"):
				child.queue_free()
		MultiplayerSetUp.reset_network_connection()
	Global.reset()
	get_tree().change_scene("res://User Interfaces/StartMenu.tscn")
