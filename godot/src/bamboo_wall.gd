extends StaticBody2D

const KILLZONE = 8.0

@export
var speed = 30.0

@export
var hp = 100.0

var main
var dmg_display

func _enter_tree() -> void:
	self.main = get_node("/root/Main")
	self.dmg_display = get_node("/root/Main/DmgNumDisplay")

func disable_tutorial() -> void:
	$Tutorial.hide()
	hp *= 2.0

func make_boss() -> void:
	self.speed *= .75
	self.hp *= 10.0
	self.scale *= 2.0

# var hit_rot = 0.1
func damage(dmg: float) -> void:
	if self.hp <= 0.0:
		return
	self.hp -= dmg
	self.dmg_display.add_number(dmg, Color(1, 1, 1))
	if self.hp < 0.0:
		main.bonus_difficulty += 2
		main.spawn_obj()
		var dead_bam_fab = load("res://fab/bamboo_falling.tscn")
		var dead_bam = dead_bam_fab.instantiate()
		dead_bam.global_position = self.global_position
		main.get_node("DeadBamboo").add_child(dead_bam)
		queue_free()
	else:
		$sfx_hit.play()
		$Anim.play("new_animation")

# var rot_speed = 10.0

func _process(delta: float) -> void:
	# $Sprites.rotate(($Sprites.global_rotation / -2.0) * delta * rot_speed)
	var velocity = Vector2(1, 0) * speed * delta
	self.position -= velocity
	if self.global_position.x <= KILLZONE:
		get_tree().change_scene_to_file("res://scn/lose.tscn")
