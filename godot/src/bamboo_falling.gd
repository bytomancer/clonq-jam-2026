extends Node2D

const FORCE = 25.0
const LEAF_FORCE = 50.0
const TTL = 3.0
var timer = 0.0

func _ready() -> void:
	for stalk in $Stalks.get_children():
		var angle = lerpf(-1*PI, PI, randf())
		var dir = Vector2.DOWN.rotated(angle)
		stalk.apply_impulse(dir * FORCE)
		stalk.gravity_scale *= 10.0
		stalk.mass = 0.1
	for leaf in $Leaves.get_children():
		var angle = lerpf(-1*PI, PI, randf())
		var dir = Vector2.DOWN.rotated(angle)
		leaf.apply_impulse(dir * LEAF_FORCE)
		leaf.gravity_scale *= 5.0
		leaf.mass = 0.1

func _process(delta: float) -> void:
	timer += delta
	self.modulate.a8 = lerp(255, 0, timer/TTL)
	if timer > TTL:
		queue_free()
