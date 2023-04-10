extends 'res://addons/gut/test.gd'

var TwoHitBrick = load("res://Objects/2HitBrick.gd")

func test_hit():
	var brick = TwoHitBrick.new()
	var orig_num_bricks = Global.get_num_bricks()
	var first_texture = brick.get_texture()
	
	brick.hit()
	assert_ne(brick.get_texture(), first_texture)
	
	brick.hit()
	assert_true(brick.is_queued_for_deletion())
	assert_eq(Global.get_num_bricks(), orig_num_bricks - 1)
