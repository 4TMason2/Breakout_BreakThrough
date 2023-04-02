extends Node

var max_lives = 3
var lives = max_lives
var hud # Pointer to the HUD

func lose_life():
	lives -= 1
	hud.load_hearts()
	if lives <= 0:
		get_tree().change_scene("res://User Interfaces/GameOver.tscn")
