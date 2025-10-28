@abstract class_name MoveBit2D extends MoveBit
## A MoveBit that's specifically 2D

## The state machine this belongs to.
@onready var master:MoveMasterBit2D = get_master()
func get_master() -> MoveMasterBit2D:
	var parent = get_parent()
	if parent is MoveMasterBit2D:
		return parent
	
	for child in parent.get_children():
		if child is MoveMasterBit2D:
			return child
	
	return null

func vec2_move_towards(from:Vector2, to:Vector2, delta:float):
	return Vector2(move_toward(from.x, to.x, delta), move_toward(from.y, to.y, delta))
