extends Node2D

const MAX_DIFF = 200
const MIN_DIFF = 0
const GAME_TIME_SOFT_LIMIT = 45.0

@export
var difficulty = 0.0

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

func _ready() -> void:
	self.set_difficulty(300)
	self.reset_bam_timer()
	self.reset_obj_timer()
	self.reset_pup_timer()
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
	
	if total_time_played > GAME_TIME_SOFT_LIMIT and next_bam_timer <= 0 and next_obj_timer <= 0 and next_pup_timer <= 0:
		if %BambooHolder.get_child_count() == 0:
			get_tree().change_scene_to_file("res://scn/win.tscn")

func reset_bam_timer() -> void:
	if total_time_played > GAME_TIME_SOFT_LIMIT:
		return
	print("BAM TIME")
	var rand_bonus = lerpf(4.0, 2.0, difficulty)
	var rand_base = lerpf(8.0, 12.0, difficulty)
	next_bam_timer = randf() * rand_bonus + rand_base

func reset_obj_timer() -> void:
	if total_time_played > GAME_TIME_SOFT_LIMIT:
		return
	print("OBJ TIME")
	var rand_bonus = lerpf(3.0, 1.0, difficulty)
	var rand_base = lerpf(5.0, 8.0, difficulty)
	next_obj_timer = randf() * rand_bonus + rand_base

func reset_pup_timer() -> void:
	if total_time_played > GAME_TIME_SOFT_LIMIT:
		return
	print("PUP TIME")
	var rand_bonus = lerpf(7.0, 3.0, difficulty)
	var rand_base = lerpf(8.0, 12.0, difficulty)
	next_pup_timer = randf() * rand_bonus + rand_base
