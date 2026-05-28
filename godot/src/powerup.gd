extends Area2D

@export
var speed = 80.0

func _process(delta: float) -> void:
	self.position.x -= speed * delta

func disable_tutorial():
	$Tutorial.hide()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Guy":
		body.get_parent().powerup()
		print("POWERUP")
		queue_free()
