extends "res://Objects/Ball.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_PurchaseButton_pressed():
	get_node("Ball").set_texture("res://Assets/Sprites/transparentBall.png")
	
func _on_PurchaseButton1_pressed():
	get_node("Ball").set_texture("res://Assets/Sprites/redBall.png")

func _on_PurchaseButton2_pressed():
	get_node("Ball").set_texture("res://Assets/Sprites/camoBall.png")
	
func _on_PurchaseButton4_pressed():
	get_node("Ball").set_texture("res://Assets/Sprites/Balter_White.png")
#Ball.$Sprite.set_texture()
