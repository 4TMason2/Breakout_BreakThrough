extends Sprite

var numHits = 2
var firstHitSprite = preload("res://Assets/Sprites/2hitbrick-cracked.png")

func hit():
	numHits -= 1
	if numHits == 1:
		set_texture(firstHitSprite)
	else:
		queue_free()
		Global.brick_break()
