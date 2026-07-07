class_name State
extends RefCounted

var owner
var machine

var _active := false

func _init(_owner) -> void:
	owner = _owner

func enter(prev_state: State) -> void:
	_active = true

func exit(next_state: State) -> void:
	_active = false

func input_update(event) -> void: pass
func update(delta) -> void: pass
func physics_update(delta) -> void: pass

func is_active() -> bool:
	return _active