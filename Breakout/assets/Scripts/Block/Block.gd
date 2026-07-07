extends StaticBody2D
class_name Block

@export_category("参数")
## HP
@export var hp: int = 1

func _ready() -> void:
	pass
	
func hit(attack: int) -> void:
	hp -= attack
	if (hp <= 0):
		queue_free()