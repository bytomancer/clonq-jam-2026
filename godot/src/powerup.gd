extends StaticBody2D

@export
var speed = 80.0

var consumed = false

func _process(delta: float) -> void:
	self.position.x -= speed * delta

func disable_tutorial():
	$TutNode.hide()

func damage(_dmg: float) -> void:
	self.consume()

func _on_body_entered(_body: Node2D) -> void:
	self.consume()

func consume() -> void:
	if self.consumed:
		return
	get_node("/root/Main/Player").powerup()
	self.consumed = true
	# TODO: sparkly animation or something?
	queue_free()
