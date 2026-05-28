extends Node2D

@export
var player_speed = 300.0;

@export
var target: Node2D

@export
var damage_multiplier = 1.0

var previous_knife_ang_vel = 0.0

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
