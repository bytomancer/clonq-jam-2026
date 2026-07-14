extends RigidBody2D

@export
var tutorial_speed = 8000.0

@export
var normal_speed = 12000.0

var speed = tutorial_speed

@export
var hp = 0.1

@export
var damage_value = 10.0

func disable_tutorial() -> void:
	$TutNode.hide()
	speed = normal_speed

func damage(_dmg: float) -> void:
	pass

func _ready() -> void:
	var flight_vel = Vector2(-1, 0) * speed
	self.apply_force(flight_vel)
	if !$TutNode.visible:
		$sfx_spawn.play()

func _process(delta: float) -> void:
	if self.hp <= 0.0:
		return

func _on_area_2d_body_entered(body: Node2D) -> void:
	if self.hp <= 0.0:
		return
	# print("Arrow hit %s" % body.name)
	if body.name == "Knife":
		kill_self()
	elif body.name == "Guy":
		body.get_parent().damage()
		# body.damage(damage_value)
	elif body.name == "Bird":
		pass

func kill_self():
	if self.hp <= 0.0:
		return
	self.hp = 0.0
	self.gravity_scale *= 5.0
	$Sprite.hide()
	$TutNode/Tutorial.text = "safe now!"

	#TODO: actually enable these as physics objects
	#Right now they just stay stuck, which is... okay?
	
	$sfx_break.play()

	$DeadArrowTip.global_position = self.global_position
	$DeadArrowTip.show()
	$DeadArrowTip.disable_mode = PROCESS_MODE_INHERIT

	$DeadArrowShaft.global_position = self.global_position
	$DeadArrowShaft.show()
	$DeadArrowShaft.disable_mode = PROCESS_MODE_INHERIT


func _on_arrow_dmg_detector_area_entered(area: Area2D) -> void:
	if self.hp <= 0.0:
		return
	if area.name == "Slicer":
		kill_self()

func set_difficulty(diff: float) -> void:
	self.normal_speed *= 1.0 + diff
