extends Sprite


var numHits = 2
var firstHitSprite = preload("res://Assets/Sprites/2hitbrick-cracked.png")

func hit():
	
	numHits -= 1
	if numHits <= 0:
		queue_free()
		Global.brick_break()
	else:
		set_texture(firstHitSprite)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
