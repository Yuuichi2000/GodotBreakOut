class_name StateMachineCore
extends RefCounted

var _states: Dictionary[Script, State] = {}
var _stack: Array[Script] = []

var _current: State = null
var _locked: bool = false

func add_state(state: State) -> void:
	var key: Script = state.get_script()
	assert(not _states.has(key), "State already registered")
	
	_states[key] = state
	state.machine = self

func has_state(state_type: Script) -> bool:
	return _states.has(state_type)

func change_state(state_type: Script) -> void:
	if _locked:
		return
	
	assert(_states.has(state_type), "State not registered")

	var next: State = _states[state_type]
	var prev: State = _current

	_locked = true

	if _current != null:
		_current.exit(next)

	_stack.clear()
	_stack.push_back(state_type)

	_current = next
	_current.enter(prev)

	_locked = false

func push_state(state_type: Script) -> void:
	if _locked:
		return
	
	assert(_states.has(state_type), "State not registered")

	var next: State = _states[state_type]
	var prev: State = _current

	_locked = true

	if _current != null:
		_current.exit(next)

	_stack.push_back(state_type)

	_current = next
	_current.enter(prev)

	_locked = false

func pop_state() -> void:
	if _locked:
		return
	
	if _stack.size() <= 1:
		return

	_locked = true

	var exiting: State = _current
	_stack.pop_back()

	var state_type: Script = _stack.back()
	var next: State = _states[state_type]

	exiting.exit(next)

	_current = next
	_current.enter(exiting)

	_locked = false

func get_current() -> State:
	return _current


func is_in(state_type: Script) -> bool:
	if _current == null:
		return false
	
	return _current.get_script() == state_type