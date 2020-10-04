extends Node2D

export (PackedScene) var scene = null

func _process(delta):
	var right_mouse = Input.is_mouse_button_pressed(1)
	if right_mouse:
		if scene != null:
			get_tree().change_scene_to(scene)
		else:
			get_tree().quit()
		
	var escape = Input.is_action_just_pressed("ui_cancel")
	if escape:
		get_tree().quit()
