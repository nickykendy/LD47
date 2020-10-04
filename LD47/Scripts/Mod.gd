extends Area2D

var canGrab = false
var isGrabbed = false
var plot = null
var index : int
var initPos : Vector2
var controller

export var content : int = 0


func _ready():
	initPos = global_position
	var _c = get_tree().get_nodes_in_group("Controller")
	if _c != []:
		controller = _c[0]


func _process(delta):
	var _left_mouse = Input.is_mouse_button_pressed(1)
	
	if canGrab and controller:
		if _left_mouse and controller.hold == null:
			if plot:
				return
			isGrabbed = true
			controller.hold = self
		elif !_left_mouse  and controller.hold != null:
			_release_grab()
			controller.hold = null
	
	
	if isGrabbed:
		global_position = get_global_mouse_position()


func _release_grab():
	if isGrabbed:
		isGrabbed = false
		if plot != null:
			if plot.has_method("insert_plot"):
				plot.insert_plot(self)
		else:
			position = initPos


func _on_Mod_body_entered(body):
	if body.is_in_group("Controller"):
		canGrab = true
		


func _on_Mod_body_exited(body):
	if body.is_in_group("Controller"):
		canGrab = false


func change_plot(value):
	plot = value
