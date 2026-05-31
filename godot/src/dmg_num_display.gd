extends Node2D

var dmg_pt

func _enter_tree() -> void:
	self.dmg_pt = get_node("/root/Main/Player").get_dmg_pt()

func add_txt(text: String, color: Color) -> void:
	var new_node: Label = $NumPopup.duplicate()
	var lab_set = new_node.label_settings.duplicate()
	new_node.label_settings = lab_set
	new_node.text = text
	new_node.label_settings.font_color = color
	new_node.global_position = dmg_pt.global_position
	new_node.create()
	new_node.show()
	add_child(new_node)

func add_number(num: float, color: Color) -> void:
	var num_i = roundi(num)
	var num_s = "%d" % num_i
	self.add_txt(num_s, color)
