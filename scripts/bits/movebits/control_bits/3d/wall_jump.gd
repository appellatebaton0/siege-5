class_name WallJumpBit3D extends ControlBit3D
## Allows a bot to wall jump. Nothing else, so this should likely be unexclusive.



func phys_active(_delta:float) -> void:
	
	
	if master.mover.is_on_wall_only() and Input.is_action_just_pressed(inputs[inp.up]):
		master.mover.velocity += master.mover.get_wall_normal() * 10.0
		master.mover.velocity.y = 10.0
	
	
func phys_inactive(_delta:float) -> void:
	pass
