extends Sprite

var numHits = 1
signal hit

func _ready():
	Global.count_bricks()

func hit():
	queue_free()
	Global.brick_break()
	
