class_name FloatControlBit extends ControlBit
## Allows for controlling the Bot like it's floating. (Top down)
## NOTE: Make sure the CharacterBody is on the Floating motion_mode.


## How fast the bot approaches max speed, per second.
@export var acceleration := 30.0
## The fastest the bot can go like this.
@export var max_speed := 90.0


func phys_active(delta:float) -> void:
	if master != null:
		# Update the directions.
		master.set_direction_x(Input.get_axis(inputs[inp.left], inputs[inp.right]))
		master.set_direction_y(Input.get_axis(inputs[inp.up], inputs[inp.down]))
		
		# Apply the velocity
		master.mover.velocity = vec2_move_towards(master.mover.velocity, master.get_direction() * max_speed, delta * acceleration)
