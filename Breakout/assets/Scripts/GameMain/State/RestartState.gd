extends State

func _game_main() -> GameMain:
	return owner as GameMain
	
func enter(prev_state: State) -> void:
	var game_main: GameMain = _game_main()
	
	# 重置玩家命数
	game_main.reset_player_life()
	
	# 重置球
	game_main.ball.reset_ball(Vector2(0, 240))
	
	# 使玩家进入准备状态
	EventBus.player_ready.emit()
	
func update(delta) -> void:
	var game_main: GameMain = _game_main()
	machine.change_state(game_main.ready_state_script)
