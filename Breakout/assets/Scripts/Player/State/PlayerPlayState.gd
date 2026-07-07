extends State

func _player() -> Player:
	return owner as Player
	
func enter(prev_state: State) -> void:
	EventBus.player_ready.connect(player_ready)
	
func input_update(event) -> void:
	pass
	
func update(delta) -> void:
	var player = _player()
	
	player._move_direction = player.MoveDirection.None
	player._pre_first_input = player._first_input
	
	# 上一帧的x坐标
	var pre_pos_x = player.global_position.x
	
	if Input.is_action_pressed(InputActionList.get_input_action(InputActionList.InputAction.MoveLeft)):
		player.global_position.x -= player._move_speed

	if Input.is_action_pressed(InputActionList.get_input_action(InputActionList.InputAction.MoveRight)):
		player.global_position.x += player._move_speed
		
	# 坐标矫正
	player.global_position.x = clamp(player.global_position.x, player._min_pos_x, player._max_pos_x)
	
	# 判断移动方向
	if (player.global_position.x > pre_pos_x):
		player._move_direction = player.MoveDirection.Right
	elif (player.global_position.x < pre_pos_x):
		player._move_direction = player.MoveDirection.Left
		
	if (player._first_input == false && player.global_position.x != pre_pos_x):
		player._first_input = true
		
func exit(next_state: State) -> void:
	EventBus.player_ready.disconnect(player_ready)
	
func player_ready() -> void:
	var player = _player()
	machine.change_state(player.ready_state_script)