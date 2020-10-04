extends Node2D

class_name Level

onready var panel = $Panel
export var maxPlot = 1
export (PackedScene) var nextScene = null

var robots
var isPlaying = false


func _ready():
	panel.plotNum = maxPlot
	if panel.has_method("init"):
		panel.init()
	
	robots = get_tree().get_nodes_in_group("Robot")
	if robots != []:
		if robots[0].has_method("init"):
			robots[0].maxCount = maxPlot
			robots[0].init()

func _on_EndPos_body_entered(body):
	if body.is_in_group("Robot"):
		emit_part()


func emit_part():
	$EndPos/Particles2D.emitting = true
	$Timer.start()


func _on_Timer_timeout():
	get_tree().change_scene_to(nextScene)


func _on_Button_pressed():
	var _b = false
	for _plot in panel.plots:
		if _plot != null:
			_b = true
			
	if !isPlaying and _b:
		isPlaying = true
			
		if robots != []:
			if robots[0].has_method("lets_loop"):
				robots[0].lets_loop()
		$Button.text = "RESET"
	elif isPlaying:
		get_tree().reload_current_scene()
