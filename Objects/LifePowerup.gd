extends Area2D

export var velocity = Vector2()
export var spriteSize = int()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	translate(velocity * delta)
	
	# Player missed the powerup
	if get_position().y - spriteSize >= get_viewport_rect().size.y:
		queue_free()

func _on_Powerup_body_entered(body):
	if body.name == "Slider":
		queue_free()
		Global.add_life()
