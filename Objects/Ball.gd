extends KinematicBody2D

var BALL_SPEED = 500

var ball_vel = Vector2(0, BALL_SPEED)
var prev_ball_vel = ball_vel
var start_pos
var is_paused = false
var pause_time = 2.0
var pause_timer = 0.0
var ball_normal
var ball_spedUp = preload("res://Assets/Sprites/ball_spedup(3).png")
var spedUp_time = 0.0

var textures = [
	"res://Assets/Sprites/ball.png",
	"res://Assets/Sprites/redBall.png",
	"res://Assets/Sprites/camoBall.png",
	"res://Assets/Sprites/glowingBall.png",
]

func _ready():
	Global.load_store()
	$Sprite.texture = load(textures[Global.store.selected])
	ball_normal =  load(textures[Global.store.selected])
	start_pos = position
	# Makes it go in a random direction
	randomize()
	ball_vel = Vector2(rand_range(-1,1),rand_range(-1,1)).normalized() * BALL_SPEED
	pause_ball()
	#ball_vel = Vector2(0,BALL_SPEED)

func pause_ball():
	position = start_pos
	prev_ball_vel = ball_vel
	ball_vel = Vector2.ZERO
	is_paused = true


func _process(delta):
	
	if is_paused:
		# Increase the pause timer, if after a given amount of time, move the ball
		pause_timer = pause_timer + delta
		if pause_timer >= pause_time:
			is_paused = false
			pause_timer = 0.0
			ball_vel = prev_ball_vel

	# Ball is off screen
	if position.y > get_viewport_rect().size.y:
		Global.lose_life()
		
		if Global.lives <= 0:
			queue_free()
		else:

			reset_ball_speed()
			pause_ball()
		
	if not is_paused:
		if spedUp_time > 0: 
			spedUp_time -= delta 
		else:
			reset_ball_speed()
		# print("not paused")
		ball_vel = ball_vel.normalized() * BALL_SPEED
		



func reset_ball_speed():
	get_node("Sprite").set_texture(ball_normal)
	BALL_SPEED = 500

func _physics_process(delta):
	var collision_info = move_and_collide(ball_vel*delta)
	if collision_info:
		var collider = collision_info.get_collider()
		if collider.name == "Slider":
			ball_vel = (self.global_position - collider.global_position) \
				.normalized()*BALL_SPEED
		else:
			ball_vel = ball_vel.bounce(collision_info.get_normal())
			if collider.get_parent().is_in_group("spec_Bricks"):
				collider.get_parent().hit()
				#if (Global.num_bricks > 8): 
				#failed attempt to make the ball speeds up more when the boss gets low on health
				BALL_SPEED = BALL_SPEED*120/100 # 125 -> 120
				#else: BALL_SPEED = BALL_SPEED*1500/100
				get_node("Sprite").set_texture(ball_spedUp)
				spedUp_time = 1.5 # change from 2.0 -> 1.5
			else:
				if collider.get_parent().is_in_group("Bricks"):
					collider.get_parent().hit()
			
