extends Node2D

const MAX_DIFF = 255
const MIN_DIFF = 0
const GAME_TIME_SOFT_LIMIT = 25.0

var difficulty = 0.0

#@export
#var starting_diff = 0

# 0 diff: 1 bamboo every 8-12s base 8 rand to +4
# 200 diff: 1 bamboo every 2-4s base 2 rand to +2
var next_bam_timer = 0.0

# 0 diff: 1 smallobj every 5-8s base 5 rand to +3
# 200 diff: 1 smallobj every 1-2s base 1 rand to +1
var next_obj_timer = 0.0

# 0 diff: 1 powerup every 8-15s base 8 rand to +7
# 200 diff: 1 powerup every 12-15s base 12 rand to +3
var next_pup_timer = 0.0

var total_time_played = 0.0

var bam_fab = preload("res://fab/bamboo_wall.tscn")
var bird_fab = preload("res://fab/bird.tscn")
var arrow_fab = preload("res://fab/arrow.tscn")
var pup_fab = preload("res://fab/powerup.tscn")

var final_bam = false

@onready
var player_ref = get_node("/root/Main/Player")

@onready
var dmg_num_display_ref = get_node("/root/Main/DmgNumDisplay")

func _ready() -> void:
	next_bam_timer = 10.0
	next_obj_timer = 7.0
	self.reset_pup_timer(false)
	total_time_played = 0.0

func set_difficulty(diff) -> void:
	var diff_i = clamp(diff, MIN_DIFF, MAX_DIFF)
	var diff_f = diff_i / MAX_DIFF
	print("Incoming difficulty is %d" % diff)
	print("Setting difficulty to %d" % diff_i)
	print("Difficulty scale at %d" % diff_f)
	self.difficulty = diff_f

func _process(delta: float) -> void:
	total_time_played += delta

	next_bam_timer -= delta
	if next_bam_timer <= 0.0:
		reset_bam_timer()
	
	next_obj_timer -= delta
	if next_obj_timer <= 0.0:
		reset_obj_timer()
	
	next_pup_timer -= delta
	if next_pup_timer <= 0.0:
		reset_pup_timer()
	
	if total_time_played > GAME_TIME_SOFT_LIMIT:
		if final_bam:
			if %BambooHolder.get_child_count() == 0:
				get_tree().change_scene_to_file("res://scn/win.tscn")
		else:
			spawn_bam(true)
			final_bam = true


func reset_bam_timer(perf_spawn = true) -> void:
	if total_time_played > GAME_TIME_SOFT_LIMIT:
		return
	if perf_spawn:
		spawn_bam()
	var rand_bonus = lerpf(1.5, 0.7, difficulty)
	var rand_base = lerpf(4.0, 2.0, difficulty)
	next_bam_timer = randf() * rand_bonus + rand_base

func spawn_bam(stronger = false):
	print("BAM TIME")
	var bamboo = bam_fab.instantiate()
	bamboo.disable_tutorial()
	bamboo.global_position = Vector2(299.0, 160.0)
	if stronger:
		bamboo.make_boss()
	else:
		bamboo.hp *= 1.0 + (difficulty as float / MAX_DIFF as float)
	# DO NOT CHANGE THE SPEED IT CAUSES CLIPPING
	#var speed_mod = 1.0 + difficulty
	#bamboo.speed *= speed_mod
	%BambooHolder.add_child(bamboo)

const EXTRA_OBJ_TIME = 5.0

func reset_obj_timer(perf_spawn = true) -> void:
	if total_time_played > GAME_TIME_SOFT_LIMIT + EXTRA_OBJ_TIME:
		return
	if perf_spawn:
		spawn_obj()
	var rand_bonus = lerpf(0.2, 0.1, difficulty)
	var rand_base = lerpf(0.8, 0.4, difficulty)
	next_obj_timer = randf() * rand_bonus + rand_base

func spawn_obj():
	print("OBJ TIME")
	# 2x arrows vs birds
	var bird = randi() % 3 == 0
	var obj
	if bird:
		obj = bird_fab.instantiate()
	else:
		obj = arrow_fab.instantiate()
	obj.disable_tutorial()
	
	var margin = 8.0
	var rand_height = randf_range(margin, 160 - margin)
	obj.global_position = Vector2(299.0, rand_height)
	%ObjectHolder.add_child(obj)

func reset_pup_timer(perf_spawn = true) -> void:
	if total_time_played > GAME_TIME_SOFT_LIMIT:
		return
	if perf_spawn:
		spawn_pup()
	var rand_bonus = lerpf(5.0, 6.0, difficulty)
	var rand_base = lerpf(8.0, 12.0, difficulty)
	next_pup_timer = randf() * rand_bonus + rand_base

func spawn_pup():
	print("PUP TIME")
	var pup = pup_fab.instantiate()
	pup.disable_tutorial()
	
	var margin = 16.0
	var rand_height = randf_range(margin, 160 - margin)
	pup.global_position = Vector2(299.0, rand_height)
	%ObjectHolder.add_child(pup)
