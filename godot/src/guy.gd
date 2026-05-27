extends CharacterBody2D

const SLOW_VEL = 10.0
const FAST_VEL = 100.0

func _process(_delta: float):
	if self.get_real_velocity().length() < SLOW_VEL:
		if $Sprite.animation != "still":
			$Sprite.animation = "still"
	elif self.get_real_velocity().length() < FAST_VEL:
		if $Sprite.animation != "slow":
			$Sprite.animation = "slow"
	else:
		if $Sprite.animation != "fast":
			$Sprite.animation = "fast"
	pass
