extends Control

onready var score: Label = get_node("Score")

func _ready():
	Global.connect("score_updated",self,"update_interface")
	update_interface()
	

func update_interface():
	score.text = "Score: %s" % Global.score
