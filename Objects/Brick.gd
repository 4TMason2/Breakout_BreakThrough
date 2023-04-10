extends Sprite

signal hit

func hit():
	queue_free()
	Global.brick_break()
