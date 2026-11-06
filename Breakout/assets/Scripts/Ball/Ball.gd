extends RigidBody2D

class_name Ball

@export_category("判定相关")

## 钢体
@export var rigidBody: RigidBody2D

@export_category("各种参数")

## 球的速度
@export var velocity: float = 200.0

## 最小X轴速度
@export var minVelocityX: float = 0.1

## 最小Y轴速度
@export var minVelocityY: float = 0.2

## 是否已发球
var shotBall: bool = false

## 初始坐标
var _initial_pos: Vector2

var _reset_pending: bool = false

## 初始化
func _ready() -> void:
	rigidBody.gravity_scale = 0
	rigidBody.contact_monitor = true
	rigidBody.max_contacts_reported = 4
	rigidBody.lock_rotation = true
	rigidBody.linear_damp = 0
	rigidBody.angular_damp = 0
	_initial_pos = global_position
	
	# 设置碰撞后的信号函数
	rigidBody.body_entered.connect(_on_body_entered)

## 物理处理
func _physics_process(_delta: float) -> void:
	if (shotBall == false):
		return
	
	# 速度&角度矫正
	var _normalizedVelocity = rigidBody.linear_velocity.normalized()
	
	if (abs(_normalizedVelocity.y) < minVelocityY):
		_normalizedVelocity.y = sign(_normalizedVelocity.y) * minVelocityY

	if (abs(_normalizedVelocity.x) < minVelocityX):
		_normalizedVelocity.x = sign(_normalizedVelocity.x) * minVelocityX

	rigidBody.linear_velocity = _normalizedVelocity * velocity

## 物理处理回调：重置球的传送在这里执行
## 直接改 global_position 会被物理服务器用旧状态覆盖回来，所以 reset_ball() 只立标志，
## 在这里改 state.transform 把球送回初始位置，清掉速度并让球睡下保持静止
func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if not _reset_pending:
		return
	_reset_pending = false
	state.transform = Transform2D(0.0, _initial_pos)
	state.linear_velocity = Vector2.ZERO
	state.angular_velocity = 0.0
	state.sleeping = true

## 发球
func ShotBall() -> void:
	if shotBall:
		return
	shotBall = true
	sleeping = false
	linear_velocity = Vector2(-200, -300)

## 碰撞检测
func _on_body_entered(body: Node) -> void:
	# 与砖块的碰撞检测
	if (body is Block):
		body.hit(1)
		
	# 与玩家的碰撞检测
	if (body is Player):
		var move_direction = body.get_move_direction()
		
		match move_direction:
			Player.MoveDirection.Left:
				rigidBody.linear_velocity.x -= 120
			Player.MoveDirection.Right:
				rigidBody.linear_velocity.x += 120

## 重置球
func reset_ball() -> void:
	shotBall = false
	_reset_pending = true