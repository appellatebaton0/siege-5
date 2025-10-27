class_name VehicleControlBit extends ControlBit
## Allows for a bot to be controlled like a top-down vehicle; inputs to turn L/R, and move forwards and backwards.

@export_group("Rotation", "rotation_")
## The fastest the vehicle can turn, in degrees per second.
@export_range(0.0, 360.0) var rotation_max_speed = 30.0
## How much the rotation speed moves towards its max, per second.
@export var rotation_acceleration = 30.0
var rotation_speed := 0.0

@export_group("Movement", "move_")
## The fastest the vehicle can move forwards and backwards.
@export var move_max_speed = 60.0
## How much the speed approaches its max, per second
@export var move_acceleration = 30.0
var move_speed = 0.0

func on_active() -> void:
	pass
func on_inactive() -> void:
	pass

func active(_delta:float) -> void:
	pass
func inactive(_delta:float) -> void:
	pass

func phys_active(delta:float) -> void:
	## If LEFT input, rotate LEFT, if RIGHT rotate RIGHT
	
	# Update the directions.
	master.set_direction_x(Input.get_axis(inputs[inp.left], inputs[inp.right]))
	master.set_direction_y(Input.get_axis(inputs[inp.up], inputs[inp.down]))
	
	var direction := master.get_direction() # Clone it here for easier use.
	
	# Update the rotation speed
	if direction.x:
		rotation_speed = move_toward(rotation_speed, rotation_max_speed * direction.x, rotation_acceleration * delta)
	else:
		rotation_speed = move_toward(rotation_speed, 0, rotation_acceleration * delta)
	
	# Update the movement speed
	if direction.y:
		move_speed = move_toward(move_speed, move_max_speed * direction.y, move_acceleration * delta)
	else:
		move_speed = move_toward(move_speed, 0, move_acceleration * delta)
	
	## Apply these values to the bot
	if bot.is_class("Node2D"):
		bot.rotate(deg_to_rad(rotation_speed * delta))
		
		master.mover.velocity = Vector2(0, move_speed).rotated(bot.rotation)

	
func phys_inactive(_delta:float) -> void:
	pass
