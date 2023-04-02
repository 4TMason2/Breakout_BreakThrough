extends CanvasLayer

func _ready():
	load_hearts()
	Global.hud = self

func load_hearts():
	$BallFull.rect_size.x = Global.lives * 62
	$BallEmpty.rect_size.x = (Global.max_lives - Global.lives) * 62
	$BallEmpty.rect_position.x = $BallFull.rect_position.x + $BallFull.rect_size.x * $BallFull.rect_scale.x
