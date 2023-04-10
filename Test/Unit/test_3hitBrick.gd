extends 'res://addons/gut/test.gd'

var ThreeHitBrick = load("res://Objects/3hitBrick.gd")

func test_hit():
	var brick = ThreeHitBrick.new()
	var orig_num_bricks = Global.get_num_bricks()
	var first_texture = brick.get_texture()
	
	brick.hit()
	var second_texture = brick.get_texture()
	assert_ne(brick.get_texture(), first_texture)
	
	brick.hit()
	assert_ne(brick.get_texture(), second_texture)
	
	brick.hit()
	assert_true(brick.is_queued_for_deletion())
	assert_eq(Global.get_num_bricks(), orig_num_bricks - 1)
