extends Control

func reduce_hearts():
	var h = $Grid/HeartGrid.get_child(0)
	if h != null:
		h.hide()
		h.queue_free()

func _ready() -> void:
	set_damage_multiplier(1.0)

func get_heart_count():
	return $Grid/HeartGrid.get_child_count()

func set_damage_multiplier(mult: float):
	$Grid/Multiplier.text = "MULT:%dX" % mult
