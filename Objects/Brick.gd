extends Sprite

var numHits = 1
signal hit
const LIFE_POWERUP_PATH = "res://Objects/LifePowerup.tscn"
const CLONE_POWERUP_PATH = "res://Objects/CloneBall.tscn"

func _ready():
	Global.count_bricks()

func hit():
	# Random chance to spawn the powerup, bool if it should or not
	randomize()
	var chance = randf()
	
	if Global.startM == 0:
		if Global.num_bricks > 1 and chance > 0.7:
			
			# Picks which power up to drop
			var chance2 = randf()
			if chance2 > 0.5:
				var life_powerup = load(LIFE_POWERUP_PATH).instance()
				get_tree().get_root().add_child(life_powerup)
				life_powerup.global_position = global_position
			else:
				var clone_powerup = load(CLONE_POWERUP_PATH).instance()
				get_tree().get_root().add_child(clone_powerup)
				clone_powerup.global_position = global_position
	
	
	queue_free()
	Global.score += 15
	Global.brick_break()
	
