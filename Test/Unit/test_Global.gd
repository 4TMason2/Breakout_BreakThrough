extends 'res://addons/gut/test.gd'

var Brick = load("res://Objects/Brick.gd")

func test_count_bricks():
	var test_bricks = []
	for i in range(1, 3):
		var brick = Brick.new()
		get_tree().get_current_scene().add_child(brick)
		test_bricks.append(brick)
	Global.count_bricks()
	assert_eq(Global.num_bricks, 3)
	assert_eq(Global.bricks.size(), 3)
	for brick in Global.bricks:
		assert_true(brick in test_bricks)
