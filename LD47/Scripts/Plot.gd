extends Area2D

class_name Plot

signal plot_inserted

var index : int
var insertedMod = null



func _process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("Controller"):
			var _mod = body.hold
			if _mod and _mod.has_method("change_plot"):
				_mod.change_plot(self)


func _on_Plot_body_exited(body):
	if body.is_in_group("Controller"):
		var _mod = body.hold
		if _mod and _mod.has_method("change_plot"):
			_mod.change_plot(null)


func insert_plot(mod):
	if insertedMod != null:
		return
	
	mod.position = global_position
	insertedMod = mod
	emit_signal("plot_inserted", index, mod)
