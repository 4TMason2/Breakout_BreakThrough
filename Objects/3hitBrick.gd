extends Sprite

var numHits = 3
var firstHitSprite = preload("res://Assets/Sprites/3hitbrick-1crack.png")
var secondHitSprite = preload("res://Assets/Sprites/3hitbrick-2cracked.png")

func hit():
	
	numHits -= 1 
	
	if numHits == 2:
		set_texture(firstHitSprite)
	if numHits == 1:
		set_texture(secondHitSprite)
	
	if numHits <= 0:
		Global.brick_break()
		queue_free()
	
