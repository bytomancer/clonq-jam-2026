extends Node2D

@export
var player_speed = 300.0;

@export
var target: Node2D

@export
var damage_multiplier = 1.0

var previous_knife_ang_vel = 0.0

func disable_tutorial() -> void:
	$Tutorial.hide()

func _process(delta: float) -> void:
	var diff: Vector2 = get_global_mouse_position() - target.global_position
	if diff.length() > player_speed * delta:
		diff = diff.normalized() * player_speed * delta
	target.velocity = diff / delta
	target.move_and_slide()
	previous_knife_ang_vel = $Knife.angular_velocity

func _on_slicer_body_entered(body: Node2D) -> void:
	var knife_speed = abs(previous_knife_ang_vel)
	var dmg = knife_speed * damage_multiplier
	print(dmg)
	body.damage(dmg)

func powerup() -> void:
	damage_multiplier += 1.0
	%HUD.set_damage_multiplier(damage_multiplier)

func damage() -> void:
	if $Guy.invuln_timer >= 0:
		return
	$Guy.start_invuln()
	reduce_hearts()

func reduce_hearts() -> void:
	if %HUD.get_heart_count() == 1:
		get_tree().change_scene_to_file("res://scn/lose.tscn")
	%HUD.reduce_hearts()
