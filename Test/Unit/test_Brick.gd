extends 'res://addons/gut/test.gd'

var Brick = load("res://Objects/Brick.gd")

func test_hit():
	var brick = Brick.new()
	brick.hit()
	assert_true(brick.is_queued_for_deletion())
	assert_eq(Global.get_num_bricks(), -1)
