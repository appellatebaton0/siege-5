class_name CameraBit3D extends Bit
## Provides functionality for a node to pivot along with the mouse.

## The node to pass the Y rotation to
@export var y_target:NodeValue
## The node to pass the X rotation to
@export var x_target:NodeValue

@export var sensitivity:float = 5

func set_valid(value:NodeValue, amount:Vector3):
	if value != null:
		var node = value.value()
		if node is Node3D:
			node.rotation += amount


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		set_valid(x_target, Vector3(event.relative.y * 0.001 * sensitivity, 0, 0))
		set_valid(y_target, Vector3(0, event.relative.x * 0.001 * sensitivity, 0))
		
