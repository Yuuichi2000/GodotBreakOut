extends Control
class_name GameClearUIController

@export_category("绑定的Object")

@export var play_again_button: Button

## UI活动控制
func set_active(active: bool) -> void:
	visible = active
	
	if (active == true):
		process_mode = Node.PROCESS_MODE_INHERIT
	else :
		process_mode = Node.PROCESS_MODE_DISABLED