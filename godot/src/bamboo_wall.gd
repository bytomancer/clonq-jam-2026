extends StaticBody2D

const KILLZONE = 8.0

@export
var speed = 30.0

@export
var hp = 100.0

func damage(dmg: float) -> void:
	self.hp -= dmg
	%DmgNumDisplay.add_number(dmg, Color(1,1,1))
	if self.hp < 0.0:
		queue_free()

func _process(delta: float) -> void:
	var velocity = Vector2(1, 0) * speed * delta
	self.position -= velocity
	if self.global_position.x <= KILLZONE:
		get_tree().change_scene_to_file("res://scn/lose.tscn")
