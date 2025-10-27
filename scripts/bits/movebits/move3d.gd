@abstract class_name MoveBit3D extends MoveBit

## The state machine this belongs to.
@onready var master:MoveMasterBit3D = get_master()
func get_master() -> MoveMasterBit3D:
	var parent = get_parent()
	if parent is MoveMasterBit2D:
		return parent
	return null
