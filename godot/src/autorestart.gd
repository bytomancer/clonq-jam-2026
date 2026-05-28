extends Node2D

@export
var timer = 2.0

func _process(delta: float) -> void:
	timer -= delta
	if timer <= 0.0:
		get_tree().change_scene_to_file("res://scn/pre.tscn")
