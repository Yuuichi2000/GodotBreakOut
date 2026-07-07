extends Node2D
class_name BlockGenerator

@export_category("绑定的tscn")

## 砖块的tscn
@export var block_scene: PackedScene

@export_category("参数")

## 砖块间距
@export var space_x: float = 0
@export var space_y: float = 0

## 创建所有的砖块
func create_all_blocks() -> void:
	pass