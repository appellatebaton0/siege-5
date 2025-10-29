class_name PositionBit2D extends MoveBit2D
## Sets the position to a Vector2Value. Good for EVERYTHING.

@export var position:Vector2Value ## The position to use.

func _ready() -> void:
	## Look for the values in the children.
	if position == null:
		for child in get_children():
			if child is Vector2Value:
				position = child

func phys_active(_delta:float) -> void:
	if position != null:
		master.mover.global_position = position.value()
		
