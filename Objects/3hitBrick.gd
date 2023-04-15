extends Sprite

const LIFE_POWERUP_PATH = "res://Objects/LifePowerup.tscn"
const CLONE_POWERUP_PATH = "res://Objects/CloneBall.tscn"
var numHits = 3
var firstHitSprite = preload("res://Assets/Sprites/3hitbrick-1crack.png")
var secondHitSprite = preload("res://Assets/Sprites/3hitbrick-2cracked.png")

func hit():
	
	numHits -= 1 
	
	if numHits == 2:
		set_texture(firstHitSprite)
	if numHits == 1:
		set_texture(secondHitSprite)
	
	if numHits <= 0:
		randomize()
		var chance = randf()
	
		if Global.num_bricks > 1 and chance > 0.6:
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
	
		
		Global.brick_break()
		queue_free()
