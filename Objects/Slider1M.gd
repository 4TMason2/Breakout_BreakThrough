extends KinematicBody2D

const SLIDER_SPEED = 500


onready var tween = $Tween
puppet var puppet_position = Vector2(0,0) setget puppet_position_set

var slider_vel = Vector2(0,0)

func _physics_process(_delta):
	if get_tree().has_network_peer():
		if is_network_master():
			if Input.is_action_pressed("up"):
				slider_vel.y = -SLIDER_SPEED
			if Input.is_action_pressed("down"):
				slider_vel.y = SLIDER_SPEED
			move_and_slide(slider_vel)
			slider_vel.y -= slider_vel.y*0.5
	

func puppet_position_set(new_value) -> void:
	puppet_position = new_value
	tween.interpolate_property(self, "global_position", global_position, puppet_position, 0.1)
	tween.start()


func _on_Network_tick_rate_timeout():
	if get_tree().has_network_peer():
		if is_network_master():
			rset_unreliable("puppet_position", global_position)





