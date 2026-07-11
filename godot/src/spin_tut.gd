extends Node2D

var rot_speed = 4.0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if self.visible:
		$Sprite2D.rotate(rot_speed * delta)
	else:
		$Sprite2D.rotation = 0.0
