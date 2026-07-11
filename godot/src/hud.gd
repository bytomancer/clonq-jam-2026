extends Control

@export
var health = 3

var heart_grid_ref

func _enter_tree():
	self.heart_grid_ref = $Grid/HeartGrid
	var base_heart = $Grid/HeartGrid/Heart
	for _i in range(1, health):
		var new_heart = base_heart.duplicate()
		heart_grid_ref.add_child(new_heart)

func reduce_hearts():
	var h = get_rightmost_alive_heart()
	if h != null:
		h.destroy()
	%Camera/Anim.play("shake")

func _ready() -> void:
	set_damage_multiplier(1.0)

func get_rightmost_alive_heart() -> Container:
	for i in range(health - 1, -1, -1):
		var h = heart_grid_ref.get_child(i)
		if h and !h.is_destroyed():
			return h
	return null

func get_heart_count() -> int:
	var i = 0
	for h in heart_grid_ref.get_children():
		if !h.is_destroyed():
			i += 1
	return i

func set_damage_multiplier(mult: float):
	$Grid/Multiplier.text = "MULT:%dX" % mult
