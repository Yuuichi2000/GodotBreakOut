extends Node2D
class_name GameMain

@export_category("绑定的Object")

## 球
@export var ball: Ball

## 玩家
@export var player: Player

## UI
@export var _ui_controller: UIController

## GameOver UI
@export var gameover_ui_controller: GameOverUIController

## 砖块创建器
@export var block_generator: BlockGenerator

@export_category("参数")

## 玩家生命数
@export var _player_life: int = 1

## 球的Y坐标下限
@export var _ball_y_pos_border: float = 400

@export_category("状态机脚本")

## 准备开始游戏
@export var ready_state_script: Script

## 游戏中
@export var game_state_script: Script

## 游戏结束
@export var game_over_state_script: Script

## 游戏重开
@export var restart_state_script: Script

## 状态机
var state_machine:= StateMachineNode.new()

var _player_life_init: int = 0

func _ready() -> void:
	state_machine.add_state(ready_state_script.new(self))
	state_machine.add_state(game_state_script.new(self))
	state_machine.add_state(game_over_state_script.new(self))
	state_machine.add_state(restart_state_script.new(self))
	
	state_machine.change_state(ready_state_script)
	
	_player_life_init = _player_life
	block_generator.create_all_blocks()

func _input(event: InputEvent) -> void:
	state_machine.input(event)

func _physics_process(delta: float) -> void:
	state_machine.physics_process(delta)

func _process(delta: float) -> void:
	state_machine.process(delta)
	
## 设置游戏的显示和活动状态
func set_game_active(obj_visable: bool, obj_process: bool) -> void:
	ball.visible = obj_visable
	player.visible = obj_visable
	
	if (obj_process == true):
		ball.process_mode = Node.PROCESS_MODE_INHERIT
		player.process_mode = Node.PROCESS_MODE_INHERIT
	else:
		ball.process_mode = Node.PROCESS_MODE_DISABLED
		player.process_mode = Node.PROCESS_MODE_DISABLED
		
## 重置玩家命数
func reset_player_life() -> void:
	_player_life = _player_life_init
