extends Node2D

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	var diff = get_global_mouse_position() - $Mouse.global_position
	$Mouse.move_and_collide(diff)
	pass
