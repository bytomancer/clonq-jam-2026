extends Node2D

@export
var player_speed = 300.0;

@export
var target: Node2D

@export
var damage_multiplier = 1.0

var previous_knife_ang_vel = 0.0

var dmg_display
var hud

var godmode = false

func _enter_tree() -> void:
	self.dmg_display = get_node("/root/Main/DmgNumDisplay")
	self.hud = get_node("/root/Main/HUD")

func _process(delta: float) -> void:
	var diff: Vector2 = get_global_mouse_position() - target.global_position
	if diff.length() > player_speed * delta:
		diff = diff.normalized() * player_speed * delta
	target.velocity = diff / delta
	target.move_and_slide()
	previous_knife_ang_vel = $Knife.angular_velocity

	if Input.is_action_just_released("ui_accept"):
		godmode = !godmode

func _on_slicer_body_entered(body: Node2D) -> void:
	if !body.is_in_group("damaged_by_sword_edge"):
		pass
	var knife_speed = abs(previous_knife_ang_vel)
	var dmg = knife_speed * damage_multiplier
	if dmg < 1.0:
		dmg = 1.0
	if godmode:
		dmg = 999.0
	print(dmg)
	body.damage(dmg)

func get_dmg_pt() -> Node2D:
	return $Knife/DmgNumPt

func powerup() -> void:
	$sfx_powerup.play()
	damage_multiplier += 1.0
	self.hud.set_damage_multiplier(damage_multiplier)
	dmg_display.add_txt("DMG UP!", Color8(255, 255, 0))

func damage() -> void:
	if $Guy.invuln_timer >= 0:
		return
	$sfx_hit.play()
	$Guy.start_invuln()
	reduce_hearts()

func reduce_hearts() -> void:
	if godmode:
		return
	if self.hud.get_heart_count() == 1:
		get_tree().change_scene_to_file("res://scn/lose.tscn")
	self.hud.reduce_hearts()

func _on_grab_area_body_entered(body: Node2D) -> void:
	body.consume()
