extends StaticBody2D
class_name Player

## 移动方向
enum MoveDirection {
	## 无
	None,
	
	## 向左
	Left,
	
	## 向右
	Right,
}

@export_category("参数")

## 移动速度
@export var _move_speed: float = 1.0

## 移动范围限制
@export var _min_pos_x: float = 0
@export var _max_pos_x: float = 1280

## 玩家初始坐标
@export var _player_initial_pos: Vector2 = Vector2(0, 0)

## 现在玩家的移动方向
var _move_direction: MoveDirection = MoveDirection.None

## 玩家是否首次操作
var _first_input: bool = false
var _pre_first_input: bool = false

## 准备状态
@export var ready_state_script: Script

## 游玩状态
@export var play_state_script: Script

## 状态机
var state_machine:= StateMachineNode.new()

func _ready() -> void:
	state_machine.add_state(ready_state_script.new(self))
	state_machine.add_state(play_state_script.new(self))
	
	state_machine.change_state(ready_state_script)
	
func _input(event: InputEvent) -> void:
	state_machine.input(event)
	
func _physics_process(delta: float) -> void:
	state_machine.physics_process(delta)
	
func _process(delta: float) -> void:
	state_machine.process(delta)
	
## 获取玩家的移动方向
func get_move_direction() -> MoveDirection:
	return _move_direction
	
## 获取玩家是否首次输入
func get_first_input_trigger() -> bool:
	return _first_input == true && _pre_first_input == false
	
## 重置玩家
func reset_player() -> void:
	_move_direction = MoveDirection.None
	_first_input = false
	_pre_first_input = false
	global_position = _player_initial_pos