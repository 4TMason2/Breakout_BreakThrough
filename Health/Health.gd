extends Node

signal max_changed(new_max)
signal changed(new_amount)
signal depleted 

export(int) var max_amount = 10
onready var current = max_amount

func _ready():
	_initialize() 

func set_max(new_max):
	max_amount = max(1, new_max)
	emit_signal("max_changed", max_amount)
	
func decrease():
	current -= 1
	emit_signal("changed", current)
	
func _initialize():
	emit_signal("max_changed", max_amount)
	emit_signal("changed", current)


func _on_boostSpeedBrick_brick_destroyed():
	pass # Replace with function body.
