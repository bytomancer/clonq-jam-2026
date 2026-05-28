extends Node2D
#
#var _callback_ref = JavaScriptBridge.create_callback(startTheGame)
#
#func startTheGame(args) -> void:
	#print(args)
	#get_tree().change_scene_to_file("res://scn/main.tscn")

func _process(_delta: float) -> void:
	var diff = JavaScriptBridge.eval("window.lcolonqJamStart || -1.0")
	diff = diff as int
	if diff > -0.5:
		JavaScriptBridge.eval("window.lcolonqJamStart = -1.0")
		get_tree().change_scene_to_file("res://scn/main.tscn")
