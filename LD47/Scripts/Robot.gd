extends KinematicBody2D

var speed : float = 16.0
var velocity : Vector2 = Vector2(0, 0)
var switch : bool = false
var count = 0
var mods = []
var panels

var maxCount : int

onready var timer = $Timer
onready var anim = $AnimationPlayer


const TOPDOWN : Vector2  = Vector2(0, 0)



func init():
	mods.clear()
	mods.resize(0)
	
	for i in maxCount:
		mods.append(-1)
	
	panels = get_tree().get_nodes_in_group("Panel")

func _physics_process(delta):
	if switch:
		_run_event(delta)
		

func insert_mod(insertedMods):
	clear_mods()
	
	for i in insertedMods.size():
		if insertedMods[i]:
			mods[i] = insertedMods[i].content
		else:
			mods[i] = -1
			

func clear_mods():
	for _mod in mods:
		_mod = -1


func match_mod(mod):
	match mod:
		0:
			velocity = Vector2(1, 0)
		1:
			velocity = Vector2(0, -1)
		2:
			velocity = Vector2(-1, 0)
		3:
			velocity = Vector2(0, 1)
		-1:
			velocity = Vector2(0, 0)


func _run_event(delta):
	if mods == []:
		return
	
	var _mod = mods[count]
	if _mod == null:
		_mod = -1
	
	match_mod(_mod)
	
	velocity = velocity.normalized() * speed
	velocity = move_and_slide(velocity, TOPDOWN)


func _on_Timer_timeout():
	_change_event()
	

func _change_event():
	if count < maxCount-1:
		count += 1
	else:
		count = 0
	
	set_physics_process(false)
	yield(get_tree().create_timer(0.5), "timeout")
	timer.start(1.0)
	set_physics_process(true)
	
	if panels != []:
		if panels[0].has_method("update_arrow"):
			panels[0].update_arrow(count)


func lets_loop():
	if !switch:
		timer.start(1.0)
		switch = true


func _on_Btn_Clear_pressed():
	get_tree().reload_current_scene()


func died():
	switch = false
	anim.play("Die")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Die":
		get_tree().reload_current_scene()
	
