extends StaticBody2D

const KILLZONE = 8.0

@export
var speed = 30.0

@export
var hp = 100.0

var dmg_display

func _enter_tree() -> void:
	self.dmg_display = get_node("/root/Main/DmgNumDisplay")

func disable_tutorial() -> void:
	$Tutorial.hide()

# var hit_rot = 0.1
func damage(dmg: float) -> void:
	# $Sprites.rotate(hit_rot)
	$Anim.play("new_animation")
	self.hp -= dmg
	self.dmg_display.add_number(dmg, Color(1, 1, 1))
	if self.hp < 0.0:
		queue_free()

# var rot_speed = 10.0

func _process(delta: float) -> void:
	# $Sprites.rotate(($Sprites.global_rotation / -2.0) * delta * rot_speed)
	var velocity = Vector2(1, 0) * speed * delta
	self.position -= velocity
	if self.global_position.x <= KILLZONE:
		get_tree().change_scene_to_file("res://scn/lose.tscn")
