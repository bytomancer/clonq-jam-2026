extends Label

@export
var speed = 10.0

@export
var ttl = 2.0

@export
var fade_start = 1.0

var timer = 0.0
var timer_started = false

func _process(delta: float) -> void:
	self.position.y -= speed * delta
	if timer_started:
		timer += delta
		if timer >= ttl:
			queue_free()
		elif timer >= fade_start:
			var timetofade = ttl - fade_start
			var alpha = 1.0 - ((timer - timetofade) / timetofade)
			self.modulate.a = alpha

func create() -> void:
	timer_started = true
