extends Node2D

func add_number(num: float, color: Color) -> void:
	var new_node: Label = $NumPopup.duplicate()
	var lab_set = new_node.label_settings.duplicate()
	new_node.label_settings = lab_set
	var num_i = roundi(num)
	new_node.text = "%d" % num_i
	new_node.label_settings.font_color = color
	new_node.global_position = %DmgNumPt.global_position
	new_node.create()
	new_node.show()
	add_child(new_node)
