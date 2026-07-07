extends State

func _game_main() -> GameMain:
	return owner as GameMain
	
func enter(prev_state: State) -> void:
	pass

func update(delta) -> void:
	var game_main: GameMain = _game_main()
	
	if (_detect_gameover() == false):
		return
	
	game_main._player_life -= 1
	game_main._ui_controller.set_life(game_main._player_life)
	
	if (game_main._player_life <= 0):
		machine.change_state(game_main.game_over_state_script)
		return

	game_main.ball.reset_ball(Vector2(0, 240))
	EventBus.player_ready.emit()
	machine.change_state(game_main.ready_state_script)

func _detect_gameover() -> bool:
	var game_main: GameMain = _game_main()
	if (game_main.ball.global_position.y > game_main._ball_y_pos_border):
		return true
	return false