extends Container

var destroyed = false

func is_destroyed() -> bool:
	return self.destroyed

func destroy():
	self.destroyed = true
	$Dead.show()
	$Dead.play("default")
	$Alive.hide()

func _process(_delta):
	if self.destroyed and !$Dead.is_playing():
		$Dead.hide()
