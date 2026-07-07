extends Node2D
class_name BlockGenerator

@export_category("绑定的tscn")

## 砖块的tscn
@export var block_scene: PackedScene

@export_category("参数")

## 砖块间距
@export var space: Vector2 = Vector2(0, 0)

## 砖块块数
@export var block_num_rows: int = 0
@export var block_num_cols: int = 0

## 所有砖块
var _blocks: Array[Block] = []

## 创建所有的砖块
func create_all_blocks() -> void:
	pass
	
## 注册单个砖块
func register_block(block: Block) -> void:
	_blocks.append(block)
	
## 销毁单个砖块
func unregister_block(block: Block) -> void:
	_blocks.erase(block)