class_name MoveMasterBit3D extends Bit
## Meant for a CharacterBody, provides a basis for movement
## This is a state machine!

@export var mover:CharacterBody3D

@export var initial_bit:MoveBit
var current_bit:MoveBit

## All the childed bits.
var bits:Array[MoveBit] = get_move_bits()
func get_move_bits() -> Array[MoveBit]:
	var response_bits:Array[MoveBit]
	
	# Append any children that are MoveBits.
	for child in get_children():
		if child is MoveBit:
			response_bits.append(child)
	
	return response_bits

## Change the current_bit to another.
func change_bit(to:MoveBit):
	# Run the going-out function for the old bit
	if current_bit != null:
		current_bit.on_inactive()
	
	# Change to the new bit
	current_bit = to
	
	# Run the going-in function for the new bit!
	if current_bit != null:
		current_bit.on_active()

func _ready() -> void:
	# Set mover2D
	if mover == null:
		var parent = get_parent()
		if parent is CharacterBody3D:
			mover = parent
	if mover == null:
		var me = self
		if me is CharacterBody3D:
			mover = me
	
	if initial_bit == null:
		for child in get_children():
			if child is MoveBit:
				initial_bit = child
				break
	
	if initial_bit != null:
		change_bit(initial_bit)

func _process(delta: float) -> void:
	# Run the active bit.
	if current_bit != null:
		current_bit.active(delta)
	
	# Run all the inactive bits.
	for bit in bits:
		if bit != current_bit:
			bit.inactive(delta)

func _physics_process(delta: float) -> void:
	# Run the physically active bit.
	if current_bit != null:
		current_bit.phys_active(delta)
	
	# Run all the physically inactive bits.
	for bit in bits:
		if bit != current_bit:
			bit.phys_inactive(delta)
	
	## Run on mover
	if mover != null:
		mover.move_and_slide()
		# Pass to the bot.
		if bot.is_class("Node2D"):
			bot.global_position = mover.global_position
			mover.position = Vector3.ZERO
