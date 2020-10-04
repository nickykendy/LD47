extends Area2D




func _on_Void_body_entered(body):
	if body.is_in_group("Robot"):
		if body.has_method("died"):
			body.died()
