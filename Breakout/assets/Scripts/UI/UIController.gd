extends Control

class_name UIController

@export_category("绑定对象")

## 生命值
@export var _life_ui_controller: LifeUIController

## 设定玩家生命值
func set_life(num: int) -> void:
	_life_ui_controller.set_life_num(num)