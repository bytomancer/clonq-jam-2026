extends CharacterBody2D

const SLOW_VEL = 10.0
const MID_VEL = 40.0
const FAST_VEL = 80.0

const INVULN_TIME = 2.0
var invuln_timer = 0.0
var squished = false

# func damage(_dmg: float) -> void:
# 	get_tree().change_scene_to_file("res://scn/lose.tscn")

func start_invuln() -> void:
	invuln_timer = INVULN_TIME
	$HitParticles.restart()

func _process(delta: float):
	if !get_parent().alive:
		return
	if invuln_timer <= 0:
		squished = false

	if invuln_timer >= 0:
		invuln_timer -= delta
		if squished:
			if $Sprite.animation != "flat":
				$Sprite.animation = "flat"
		else:
			if $Sprite.animation != "ow":
				$Sprite.animation = "ow"
	elif get_parent().gamewon:
		if $Sprite.animation != "fast":
			$Sprite.animation = "fast"
	elif self.get_real_velocity().length() < SLOW_VEL:
		if $Sprite.animation != "still":
			$Sprite.animation = "still"
	elif self.get_real_velocity().length() < MID_VEL:
		if $Sprite.animation != "slow":
			$Sprite.animation = "slow"
	elif self.get_real_velocity().length() < FAST_VEL:
		if $Sprite.animation != "mid":
			$Sprite.animation = "mid"
	else:
		if $Sprite.animation != "fast":
			$Sprite.animation = "fast"

	if $Sprite.animation == "ow":
		$Sprite.modulate = Color(0.5, 0.5, 0.5, 1.0)
	elif $Sprite.animation == "flat":
		$Sprite.modulate = Color(0.5, 0.5, 0.5, 1.0)
	else:
		$Sprite.modulate = Color(1.0, 1.0, 1.0, 1.0)
