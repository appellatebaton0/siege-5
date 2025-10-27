class_name StraightMoveBit2D extends MoveBit2D
## Moves in a straight, preset direction. Good for things like bullets, for example.

## The speeds to move towards for the x and y value.
@export var max_speeds:Vector2 = Vector2(30.0, 30.0)
## How much to move towards the max speeds, per second.
@export var acceleration:float = 30.0

@export_group("Dynamic Values", "value_")
@export var value_max_speeds:Vector2Value
@export var value_acceleration:FloatValue

func _ready() -> void:
	for child in get_children():
		if child is Vector2Value and value_max_speeds == null:
			value_max_speeds = child
		elif child is FloatValue and value_acceleration == null:
			value_acceleration = child

func on_active() -> void:
	if master != null:
		master.set_direction(max_speeds)

func phys_active(delta:float) -> void:
	if master != null:
		
		var this_accel := acceleration
		var this_max_speed := max_speeds
		
		## If Values exist, use those instead.
		if value_acceleration != null:
			this_accel = value_acceleration.value()
		if value_max_speeds != null:
			this_max_speed = value_max_speeds.value()
		
		
		master.mover.velocity = vec2_move_towards(master.mover.velocity, this_max_speed, this_accel * delta * 60)
