extends RigidBody2D

@export
var speed = 80.0

@export
var hp = 0.0001

func damage(dmg: float) -> void:
	if self.hp <= 0.0:
		return
	%DmgNumDisplay.add_number(dmg, Color(1,0,0))
	self.hp -= dmg
	if self.hp <= 0.0:
		$Sprite.animation = "dead"
		$Poof.restart()
		self.gravity_scale *= 5.0
		$TutNode/Tutorial.text = "=("
		$TutNode/Tutorial.label_settings.font_color = Color(1,0,0)

func _process(_delta: float) -> void:
	if self.global_position.x < -100 or self.global_position.x > get_viewport_rect().size.x + 100 or self.global_position.y < -100 or self.global_position.y > get_viewport_rect().size.y + 100:
		queue_free()
		return
	if self.hp <= 0.0:
		return
	if self.global_rotation_degrees < -5:
		self.apply_torque(5)
	elif self.global_rotation_degrees > 5:
		self.apply_torque(-5)
	var current_speed = self.linear_velocity.length()
	var allowed_speed = 2 * speed
	var flight_speed = lerpf(self.speed, 0.0, current_speed / allowed_speed)
	var flight_vel = Vector2(-1, 0).rotated(self.rotation) * flight_speed
	self.apply_force(flight_vel)
