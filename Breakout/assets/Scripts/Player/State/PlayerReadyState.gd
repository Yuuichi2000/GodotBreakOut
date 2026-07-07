extends State

## 是否切换状态
var change_state: bool = false

func _player() -> Player:
	return owner as Player
	
func enter(prev_state: State) -> void:
	var player = _player()
	player.reset_player()
	
	change_state = false
	
func input_update(event) -> void:
	var has_input = false
	if Input.is_action_pressed(InputActionList.get_input_action(InputActionList.InputAction.MoveLeft)):
		has_input = true

	if Input.is_action_pressed(InputActionList.get_input_action(InputActionList.InputAction.MoveRight)):
		has_input = true
		
	if has_input == true && change_state == false:
		change_state = true

func update(delta) -> void:
	if change_state == false:
		return
	
	EventBus.game_start.emit()
	
	var player = _player()
	machine.change_state(player.play_state_script)