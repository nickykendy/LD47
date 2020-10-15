extends Control

onready var _player = $AudioStreamPlayer

func _ready():
	_player.play()
