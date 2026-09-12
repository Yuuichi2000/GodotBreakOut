extends State

func _game_main() -> GameMain:
	return owner as GameMain
	
func enter(prev_state: State) -> void:
	var game_main: GameMain = _game_main()
	
	game_main.gameclear_ui_controller.set_active(true)
	game_main.set_game_active(true, false)
	
	game_main.gameclear_ui_controller.play_again_button.pressed.connect(_on_play_again_pressed)
	
func update(delta) -> void:
	pass
	
func exit(next_state: State) -> void:
	var game_main: GameMain = _game_main()
	
	game_main.gameclear_ui_controller.play_again_button.pressed.disconnect(_on_play_again_pressed)
	
func _on_play_again_pressed() -> void:
	var game_main: GameMain = _game_main()
	machine.change_state(game_main.restart_state_script)