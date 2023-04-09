extends KinematicBody2D

const BALL_SPEED = 500

var ball_vel = Vector2(0, BALL_SPEED)
var prev_ball_vel = ball_vel
var start_pos
var is_paused = false
var pause_time = 2.0
var pause_timer = 0.0


func _ready():
	start_pos = position
	# Makes it go in a random direction
	# ball_vel = Vector2(rand_range(-1,1),rand_range(-1,1)).normalized() * BALL_SPEED
	ball_vel = Vector2(0,BALL_SPEED)


func _process(delta):
	
	if is_paused:
		# print("is paused")
		
		# Increase the pause timer, if after a given amount of time, move the ball
		pause_timer = pause_timer + delta
		# print(pause_timer)
		if pause_timer >= pause_time:
			is_paused = false
			pause_timer = 0.0
			ball_vel = prev_ball_vel
		
	# Ball is off screen
	if position.y > get_viewport_rect().size.y:
		Global.lose_life()
		
		if Global.lives <= 0:
			end_game()
			queue_free()
		else:
			position = start_pos
			prev_ball_vel = ball_vel
			ball_vel = Vector2.ZERO
			is_paused = true
		
	if not is_paused:
		# print("not paused")
		ball_vel = ball_vel.normalized() * BALL_SPEED
		

func end_game():
	print("game over")

func _physics_process(delta):
	var collision_info = move_and_collide(ball_vel*delta)
	if collision_info:
		var collider = collision_info.get_collider()
		if collider.name == "Slider":
			ball_vel = (self.global_position - collider.global_position) \
				.normalized()*BALL_SPEED
		else:
			ball_vel = ball_vel.bounce(collision_info.get_normal())
			if collider.get_parent().is_in_group("Bricks"):
				collider.get_parent().hit()
