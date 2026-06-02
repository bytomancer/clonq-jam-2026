extends Node2D
class_name Player

@export
var max_player_speed := 300.0;

@export
var damage_multiplier: float = 1.0

var previous_knife_ang_vel: float = 0.0

var dmg_display_ref: DmgNumDisplay
var hud_ref: Control
var guy_ref: CharacterBody2D
var knife_ref: RigidBody2D

func _enter_tree() -> void:
	self.knife_ref = $Knife
	self.dmg_display_ref = get_node("/root/Main/DmgNumDisplay")
	self.hud_ref = get_node("/root/Main/HUD")
	self.guy_ref = $Guy

func _process(delta: float) -> void:
	_move_toward_mouse(delta)
	previous_knife_ang_vel = self.knife_ref.angular_velocity
	
func _move_toward_mouse(delta: float) -> void:
	var dir_to_mouse: Vector2 = get_global_mouse_position() - guy_ref.global_position
	var max_velocity_this_update := max_player_speed * delta
	var max_velocity_this_update_squared := max_velocity_this_update ** 2
	if dir_to_mouse.length_squared() > max_velocity_this_update_squared:
		dir_to_mouse = dir_to_mouse.normalized() * max_velocity_this_update
	guy_ref.velocity = dir_to_mouse / delta
	var _collided := guy_ref.move_and_slide()

func _on_slicer_body_entered(body: Node2D) -> void:
	if !body.is_in_group("damaged_by_sword_edge"):
		pass
	var knife_speed := absf(previous_knife_ang_vel)
	var dmg := knife_speed * self.damage_multiplier
	if dmg < 1.0:
		dmg = 1.0
	if body.has_method("damage"):
		body.damage(dmg)

func get_dmg_pt() -> Node2D:
	return $Knife/DmgNumPt

func powerup() -> void:
	damage_multiplier += 1.0
	self.hud_ref.set_damage_multiplier(damage_multiplier)
	dmg_display_ref.add_txt("DMG UP!", Color8(255, 255, 0))

func damage() -> void:
	if $Guy.invuln_timer >= 0:
		return
	$Guy.start_invuln()
	reduce_hearts()

func reduce_hearts() -> void:
	if self.hud_ref.get_heart_count() == 1:
		get_tree().change_scene_to_file("res://scn/lose.tscn")
	self.hud_ref.reduce_hearts()

func _on_grab_area_body_entered(body: Node2D) -> void:
	body.consume()
