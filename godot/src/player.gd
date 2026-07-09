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
var alive = true
var gamewon = false

func _enter_tree() -> void:
	self.dmg_display = get_node("/root/Main/DmgNumDisplay")
	self.hud = get_node("/root/Main/HUD")

func win_game() -> void:
	gamewon = true

func fail_game_bamboo() -> void:
	$Guy/Sprite.visible = false
	$Guy/SquishParticles.restart()
	fail_game()

func fail_game() -> void:
	$DeathMus.play()
	$GuyToKnife.node_a = NodePath("")
	$GuyToKnife.node_b = NodePath("")
	
	self.alive = false
	self.process_mode = PROCESS_MODE_ALWAYS
	# 4 = only the borders will stop the guy
	target.collision_layer = 0
	target.collision_mask = 0
	$Guy/Sprite.animation = "fall"
	get_tree().paused = true

func finally_fail_game() -> void:
	get_tree().change_scene_to_file("res://scn/lose.tscn")

var death_timer = 0.0
const DEATH_TIMER_END = 3.5

func process_death(delta: float) -> void:
	target.velocity = Vector2(-0.5, 1) * 5000 * delta
	target.move_and_slide()
	death_timer += delta
	if death_timer >= DEATH_TIMER_END:
		finally_fail_game()

# var win_timer = 0.0
# const WIN_TIMER_END = 3.5

func process_win(delta: float) -> void:
	# win_timer += delta
	# if win_timer >= WIN_TIMER_END:
	# 	get_tree().change_scene_to_file("res://scn/win.tscn")
	$Guy.squished = false
	$Guy.invuln_timer = -1.0

func _process(delta: float) -> void:
	if !alive:
		process_death(delta)
		return
	elif gamewon:
		process_win(delta)
		# no return!
	var curr_speed = player_speed
	if $Guy.squished:
		curr_speed /= 4
	elif $Guy.invuln_timer > 0:
		curr_speed /= 2
	elif gamewon:
		curr_speed /= 2
		$Knife.gravity_scale = 1.0
	var diff: Vector2 = get_global_mouse_position() - target.global_position
	if diff.length() > curr_speed * delta:
		diff = diff.normalized() * curr_speed * delta
	target.velocity = diff / delta
	target.move_and_slide()
	previous_knife_ang_vel = $Knife.angular_velocity

	if Input.is_action_just_released("ui_accept"):
		fail_game()
		# godmode = !godmode

func _on_slicer_body_entered(body: Node2D) -> void:
	if !alive:
		return
	if !body.is_in_group("damaged_by_sword_edge"):
		pass
	var knife_speed = abs(previous_knife_ang_vel)
	var dmg = knife_speed * damage_multiplier
	if dmg < 1.0:
		dmg = 1.0
	if godmode:
		dmg = 999.0
	# body.damage(dmg)
	body.call_deferred('damage', dmg)

func get_dmg_pt() -> Node2D:
	return $Knife/DmgNumPt

func powerup() -> void:
	if !alive:
		return
	$sfx_powerup.play()
	damage_multiplier += 1.0
	self.hud.set_damage_multiplier(damage_multiplier)
	dmg_display.add_txt("DMG UP!", Color8(255, 255, 0))

func damage() -> void:
	if !alive:
		return
	if $Guy.invuln_timer >= 0:
		return
	$sfx_hit.play()
	$Guy.start_invuln()
	reduce_hearts()

func squash() -> void:
	if !alive:
		return
	if $Guy.invuln_timer >= 0:
		return
	$Guy.squished = true
	damage()


func reduce_hearts() -> void:
	if !alive:
		return
	if gamewon:
		return
	if godmode:
		return
	if self.hud.get_heart_count() == 1:
		# get_tree().change_scene_to_file("res://scn/lose.tscn")
		fail_game()
	self.hud.reduce_hearts()

func _on_grab_area_body_entered(body: Node2D) -> void:
	if !alive:
		return
	body.consume()
