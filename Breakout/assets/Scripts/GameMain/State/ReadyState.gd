extends State

func _game_main() -> GameMain:
	return owner as GameMain

func enter(prev_state: State) -> void:
	var game_main: GameMain = _game_main()
	game_main._ui_controller.set_life(game_main._player_life)
	game_main.gameover_ui_controller.set_active(false)
	game_main.set_game_active(true, true)
	EventBus.game_start.connect(_game_start)
	
func exit(next_state: State) -> void:
	EventBus.game_start.disconnect(_game_start)
		
func _game_start() -> void:
	var game_main: GameMain = _game_main()
	game_main.ball.ShotBall()
	machine.change_state(game_main.game_state_script)