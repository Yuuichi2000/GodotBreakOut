class_name StateMachineNode
extends Node

var core := StateMachineCore.new()

func add_state(state: State):
	core.add_state(state)

func change_state(t: Script):
	core.change_state(t)

func push_state(t: Script):
	core.push_state(t)

func pop_state():
	core.pop_state()

func input(event):
	if core.get_current():
		core.get_current().input_update(event)

func process(delta):
	if core.get_current():
		core.get_current().update(delta)

func physics_process(delta):
	if core.get_current():
		core.get_current().physics_update(delta)

func _notification(what):
	if what == NOTIFICATION_POST_ENTER_TREE:
		set_process(true)
		set_physics_process(true)