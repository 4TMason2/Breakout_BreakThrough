extends Sprite

const LIFE_POWERUP_PATH = "res://Objects/LifePowerup.tscn"
const CLONE_POWERUP_PATH = "res://Objects/CloneBall.tscn"
var numHits = 2
var firstHitSprite = preload("res://Assets/Sprites/2hitbrick-cracked.png")
signal brick_destroyed


func hit():
	
	numHits -= 1
	if numHits <= 0:
		
		# Chance to spawn powerup
		randomize()
		var chance = randf()
		
		if Global.num_bricks > 1 and chance > 0.5:
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
		
		
		
		emit_signal("brick_destroyed")
		queue_free()
		Global.score += 25
		Global.brick_break()
	else:
		set_texture(firstHitSprite)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
