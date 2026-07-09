extends RigidBody2D

@export
var speed = 80.0

@export
var hp = 0.0001

var dmg_display

func _enter_tree() -> void:
	self.dmg_display = get_node("/root/Main/DmgNumDisplay")
	$TutNode/Tutorial.label_settings.font_color = Color(1, 1, 1)

func _ready():
	if !$TutNode.visible:
		$sfx_spawn.play()

func disable_tutorial() -> void:
	$TutNode.hide()

func damage(dmg: float) -> void:
	if self.hp <= 0.0:
		return
	self.hp = -1.0
	dmg_display.add_number(dmg, Color(1, 0, 0))
	kill_self()

func kill_self() -> void:
	$sfx_kill.play()
	get_node("/root/Main/Player").reduce_hearts()
	$Sprite.animation = "dead"
	#$Poof.restart()
	$Poof2.restart()
	$Poof3.restart()
	self.gravity_scale *= 5.0
	$TutNode/Tutorial.text = "=("
	$TutNode/Tutorial.label_settings.font_color = Color(1, 0, 0)

func _process(_delta: float) -> void:
	if self.global_position.x < -100 or self.global_position.x > get_viewport_rect().size.x + 500 or self.global_position.y < -100 or self.global_position.y > get_viewport_rect().size.y + 100:
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

func set_difficulty(diff: float) -> void:
	self.speed *= 1.0 + (diff / 4.0)

func is_bird() -> bool:
	return true
