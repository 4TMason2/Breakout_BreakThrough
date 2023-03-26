extends KinematicBody2D

const BALL_SPEED = 500

var ball_vel = Vector2(0, BALL_SPEED)

func _ready():
	pass 

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
