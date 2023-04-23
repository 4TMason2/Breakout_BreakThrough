extends KinematicBody2D

const SLIDER_SPEED = 500

var slider_vel = Vector2(0, 0)


func _physics_process(_delta):
	if Input.is_action_pressed("right"):
		slider_vel.x = SLIDER_SPEED
	if Input.is_action_pressed("left"):
		slider_vel.x = -SLIDER_SPEED
	
	move_and_slide(slider_vel)
	slider_vel.x -= slider_vel.x*0.5


