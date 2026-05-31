extends Node2D

@export
var hills_speed = 8.0

@export
var bam_speed = 23.0

var hill_layer
var bam_layer

func _enter_tree() -> void:
	self.hill_layer = $PxBg/Hills
	self.bam_layer = $PxBg/Bam

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	hill_layer.motion_offset.x -= delta * hills_speed
	bam_layer.motion_offset.x -= delta * bam_speed
