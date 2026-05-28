extends RigidBody2D

@export
var speed = 4000.0

@export
var hp = 10.0

@export
var damage_value = 10.0

# var prev_pos = Vector2(0, 0)
# var time_stalled = 0.0

var time_alive = 0.0

func damage(_dmg: float) -> void:
	pass
	# if self.hp <= 0.0:
	# 	return
	# %DmgNumDisplay.add_number(dmg, Color(1, 1, 1))
	# self.hp -= dmg
	# if self.hp <= 0.0:
	# 	self.gravity_scale *= 5.0

func _ready() -> void:
	var flight_vel = Vector2(-1, 0) * speed
	self.apply_force(flight_vel)

func _process(delta: float) -> void:
	if self.global_position.x < -100 or self.global_position.x > get_viewport_rect().size.x + 100 or self.global_position.y < -100 or self.global_position.y > get_viewport_rect().size.y + 100:
		queue_free()
		return
	if self.hp <= 0.0:
		return
	
	# if time_alive > 1.0:
	# 	var curr_speed = self.linear_velocity.length()
	# 	if curr_speed < speed / 2.0:
	# 		self.hp = 0.0
	# 		self.gravity_scale *= 5.0
	# 		return
	# elif time_alive == 0.0:
	
	time_alive += delta

	# var curr_speed = self.linear_velocity.length()
	# if curr_speed <= speed / 10.0:
	# 	time_stalled += delta
	# else:
	# 	time_stalled = 0
	
	# if time_stalled >= 1:
	# 	self.hp = 0.0
	# 	self.gravity_scale *= 5.0
	# 	return
	# var current_speed = self.linear_velocity.length()
	# var allowed_speed = 2 * speed
	# var flight_speed = lerpf(self.speed, 0.0, current_speed / allowed_speed)
	# var flight_vel = Vector2(-1, 0) * flight_speed

	# var pos_after = self.global_position
	# var pos_diff = pos_after - prev_pos
	# if pos_diff.length() < 0.1 or pos_diff.length() > 0.1:
	# 	time_stalled += delta
	# else:
	# 	time_stalled = 0

	# prev_pos = self.global_position

func _on_area_2d_body_entered(body: Node2D) -> void:
	if self.hp <= 0.0:
		return
	# print("Arrow hit %s" % body.name)
	if body.name == "Knife":
		kill_self()
	elif body.name == "Guy":
		%Player.reduce_hearts()
		# body.damage(damage_value)
	elif body.name == "Bird":
		body.damage(damage_value)

func kill_self():
	self.hp = 0.0
	self.gravity_scale *= 5.0
	$Sprite.hide()

	#TODO: actually enable these as physics objects
	#Right now they just stay stuck, which is okay

	$DeadArrowTip.global_position = self.global_position
	$DeadArrowTip.show()
	$DeadArrowTip.disable_mode = PROCESS_MODE_INHERIT

	$DeadArrowShaft.global_position = self.global_position
	$DeadArrowShaft.show()
	$DeadArrowShaft.disable_mode = PROCESS_MODE_INHERIT
