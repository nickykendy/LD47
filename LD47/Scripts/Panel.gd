extends Node2D

var _robot
var plots = []
var plotNum : int
var count : int = 0
onready var arrow = $Arrow

const PLOT : Resource = preload("res://Scenes/Plot.tscn")


func init():
	var _t = get_tree().get_nodes_in_group("Robot")
	_robot = _t[0]
	for i in plotNum:
		plots.append(null)
		var _plot = PLOT.instance()
		self.add_child(_plot)
		_plot.position = Vector2(32 + i * 48, 0)
		_plot.index = i
		_plot.connect("plot_inserted", self, "on_Panel_plot_inserted")


func _pass_to_robot(plots):
	if  _robot and _robot.has_method("insert_mod"):
		if plots.size() > 0:
			_robot.insert_mod(plots)


func clear_plots():
	plots.clear()


func on_Panel_plot_inserted(index, mod):
	plots[index] = mod
	_pass_to_robot(plots)


func update_arrow(count):
	arrow.position = Vector2(32 + count * 48, 24)
