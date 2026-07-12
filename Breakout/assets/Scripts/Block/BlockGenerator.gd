extends Node2D
class_name BlockGenerator

@export_category("绑定的tscn")

## 砖块的tscn
@export var block_scene: PackedScene

@export_category("参数")

## 砖块间距
@export var block_space: Vector2 = Vector2(0, 0)

## 砖块中央基准点
@export var block_center_pos: Vector2 = Vector2(0, 0)

## 砖块块数
@export var block_num_cols: int = 0
@export var block_num_rows: int = 0

## 所有砖块
var _blocks: Array[Block] = []

## 创建所有的砖块
func create_all_blocks() -> void:
	## 以offset为基准计算
	var half_of_block_num: Vector2 = Vector2(0, 0)
	
	half_of_block_num.x = block_num_cols / 2.0
	half_of_block_num.y = block_num_rows / 2.0
	
	## 开始创建砖块的坐标
	var block_start_pos: Vector2 = Vector2(0, 0)
	
	block_start_pos.x = block_center_pos.x - ((half_of_block_num.x - 0.5) * block_space.x)
	block_start_pos.y = block_center_pos.y - ((half_of_block_num.y - 0.5) * block_space.y)
	
	## 实例化砖块
	for y in block_num_rows:
		for x in block_num_cols:
			var block := block_scene.instantiate() as Block
			
			## 砖块坐标
			block.position = Vector2(
			block_start_pos.x + x * block_space.x,
			block_start_pos.y + y * block_space.y)
			
			## 链接销毁时的命令
			block.destroyed.connect(_on_block_destroyed)
			
			register_block(block)
			
## 销毁所有砖块
func destroy_all_blocks() -> void:
	for block in _blocks:
		unregister_block(block)
			
## 注册单个砖块
func register_block(block: Block) -> void:
	add_child(block)
	_blocks.append(block)
	
## 销毁单个砖块
func unregister_block(block: Block) -> void:
	_blocks.erase(block)
	
## 获取场景内剩余的砖块数
func get_block_count() -> int:
	return _blocks.size()
	
## 砖块消除时从列表里清除掉
func _on_block_destroyed(block: Block):
	unregister_block(block)