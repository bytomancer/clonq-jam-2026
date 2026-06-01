extends Node2D
class_name DmgNumDisplay

var dmg_pt: Node2D

func _enter_tree() -> void:
	var player: Player = get_node("/root/Main/Player") as Player
	self.dmg_pt = player.get_dmg_pt()

func add_txt(text: String, color: Color) -> void:
	var new_label := $NumPopup.duplicate() as NumPopup
	var label_settings := new_label.label_settings.duplicate()
	new_label.label_settings = label_settings
	new_label.text = text
	new_label.label_settings.font_color = color
	new_label.global_position = dmg_pt.global_position
	new_label.create()
	new_label.show()
	add_child(new_label)

func add_number(num: float, color: Color) -> void:
	var num_i := roundi(num)
	var num_s := "%d" % num_i
	self.add_txt(num_s, color)
