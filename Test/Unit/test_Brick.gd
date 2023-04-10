extends 'res://addons/gut/test.gd'

var Brick = load("res://Objects/Brick.gd")

func test_hit():
	var brick = Brick.new()
	var orig_num_bricks = Global.get_num_bricks()
	brick.hit()
	assert_true(brick.is_queued_for_deletion())
	assert_eq(Global.get_num_bricks(), orig_num_bricks - 1)
