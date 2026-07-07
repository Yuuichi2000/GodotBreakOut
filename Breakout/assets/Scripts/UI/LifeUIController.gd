extends Node2D
class_name LifeUIController

@export_category("绑定对象")

## 生命值数字部分
@export var _num_text: Label

## 设定生命值的数字
func set_life_num(num: int) -> void:
	_num_text.text = str(num)