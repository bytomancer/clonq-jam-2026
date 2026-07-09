extends StaticBody2D

const MAX_GRAV = 8.0
const MIN_GRAV = 4.0
@export var x_speed = -120.0
@export var grav = MIN_GRAV

var velocity = Vector2.ZERO

func disable_tutorial() -> void:
	$TutNode.hide()

func is_rock() -> bool:
	return true

func _process(delta: float) -> void:
	# if self.global_position.x < -100 or self.global_position.x > get_viewport_rect().size.x + 500 or self.global_position.y < -100 or self.global_position.y > get_viewport_rect().size.y + 100:
	# 	queue_free()
	# 	return
	velocity.x = x_speed;
	velocity.y += grav;
	
	self.global_position.x += velocity.x * delta;
	self.global_position.y += velocity.y * delta

func damage(_dmg: float) -> void:
	pass

func _on_hit_box_body_entered(body: Node2D) -> void:
	if body.name == "Guy":
		body.get_parent().squash()

func _on_hit_box_area_entered(_area: Area2D) -> void:
	$sfx_bounce.play()
	self.velocity.y *= -1

func set_difficulty(diff: float) -> void:
	grav = lerpf(MIN_GRAV, MAX_GRAV, diff)
