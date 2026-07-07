extends Node2D

# var hills_speed = 8.0
# var bam_speed = 10.0
# var tree_speed = 5.0
# var hill_layer2_speed = 3.0

# var hill_layer
# var hill_layer2
# var bam_layer
# var tree_layer

# func _enter_tree() -> void:
# 	self.hill_layer = $PxBg/Hills
# 	self.hill_layer2 = $PxBg/Hills2
# 	self.bam_layer = $PxBg/Bam
# 	self.tree_layer = $PxBg/Trees

# # Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta: float) -> void:
# 	hill_layer.motion_offset.x -= delta * hills_speed * 2
# 	hill_layer.motion_offset.y += delta * hills_speed * 0.5
	 
# 	tree_layer.motion_offset.x -= delta * tree_speed * 2
# 	tree_layer.motion_offset.y += delta * tree_speed * 0.5
	
# 	bam_layer.motion_offset.x -= delta * bam_speed * 2
# 	bam_layer.motion_offset.y += delta * bam_speed * 0.5
	
# 	hill_layer2.motion_offset.x -= delta * hill_layer2_speed * 2
# 	hill_layer2.motion_offset.y += delta * hill_layer2_speed * 0.5
