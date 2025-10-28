@abstract class_name ControlBit3D extends MoveBit3D
## A MoveBit that allows player control, with throughput for inputs.

enum inp{
	left, ## When the player is trying to go left
	right, ## When the player is trying to go right
	down, ## When the player is trying to go down
	up, ## When the player is trying to go up
	forwards, ## When the player is trying to go down
	backwards, ## When the player is trying to go up
	}

## Casts ControlBit inputs to InputEvents.
@export var inputs:Dictionary[inp, String] = {
	inp.left: "left",
	inp.right: "right",
	inp.down: "down",
	inp.up: "up",
	inp.forwards: "forwards",
	inp.backwards: "backwards"
}
