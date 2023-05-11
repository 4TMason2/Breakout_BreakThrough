extends KinematicBody2D

const BALL_SPEED = 250

var ball_vel = Vector2(BALL_SPEED, 0)
var prev_ball_vel = ball_vel
var start_pos 
var is_paused = false
var pause_time = 2.0
var pause_timer = 0.0

onready var tween = $Tween
puppet var puppet_position = Vector2(0,0) setget puppet_position_set
puppet var puppet_velocity = Vector2()


func _ready():
	start_pos = position
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
	if Global.startM == 0:
		pass
	else:
		if is_paused:
			# Increase the pause timer, if after a given amount of time, move the ball
			pause_timer = pause_timer + delta
			if pause_timer >= pause_time:
				is_paused = false
				pause_timer = 0.0
				ball_vel = prev_ball_vel
		else: 
			ball_vel = ball_vel.normalized() * BALL_SPEED
			
		# Ball is off screen
		if position.x > get_viewport_rect().size.x or position.x < 0 or position.y > get_viewport_rect().size.y:
			MultiplayerSetUp._server_disconnected()
			
		if not tween.is_active():
			move_and_slide(puppet_velocity * BALL_SPEED)
		

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
				#rset_id(get_tree().get_network_unique_id(), "numHits", collider.get_parent().numHits -1)
				#brick = collider.get_parent()


#var brick = null


func puppet_position_set(new_value) -> void:
	puppet_position = new_value
	tween.interpolate_property(self, "global_position", global_position, puppet_position, 0.1)
	tween.start()
	
	

func _on_Network_tick_rate_timeout():
	if get_tree().has_network_peer():
		if is_network_master():
			rset_unreliable("puppet_position", global_position)
			rset_unreliable("puppet_velocity", ball_vel)
