class_name InputActionList

## 动作名称的列举型
enum InputAction {
	MoveLeft,
	MoveRight,
}

## 动作名称字符串数组
const _INPUT_ACTIONS: Array[String] = [
	"move_left",
	"move_right",
]

## 获取输入动作名称
static func get_input_action(input_action: InputAction) -> String:
	if (input_action >= _INPUT_ACTIONS.size()):
		return ""
		
	return _INPUT_ACTIONS[input_action]