extends Area2D

# Pass any damage dealt to the arrow tip's collider to the parent
func damage(dmg: float) -> void:
	get_parent().damage(dmg)
