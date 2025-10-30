class_name LookBit extends Bit
## Makes one node look at another

## The node to make look at another.
@export var from:NodeValue

## The node to make it look at.
@export var to:NodeValue

## The axis to apply the look to.
@export_group("Axes", "look_")
@export var look_x := true
@export var look_y := true
@export var look_z := true

func _ready() -> void:
	for child in get_children():
		if child is NodeValue:
			if from == null:
				from = child
			elif to == null:
				to = child

func _process(_delta: float) -> void:
	if from != null and to != null:
		var f_node = from.value()
		var t_node = to.value()
		
		if f_node is Node2D:
			if t_node is Node2D:
				var regular_rotation = f_node.rotation
				
				f_node.look_at(t_node.global_position)
				
				var look_rotation = f_node.rotation
				
				## Apply the necessary rotations
				var real_rotation = regular_rotation
				if look_x:
					real_rotation.x = look_rotation.x
				if look_y:
					real_rotation.y = look_rotation.y
				
				f_node.rotation = real_rotation
		elif f_node is Node3D:
			if t_node is Node3D:
				var regular_rotation = f_node.rotation
				
				f_node.look_at(t_node.global_position)
				
				var look_rotation = f_node.rotation
				
				## Apply the necessary rotations
				var real_rotation = regular_rotation
				if look_x:
					real_rotation.x = look_rotation.x
				if look_y:
					real_rotation.y = look_rotation.y
				if look_z:
					real_rotation.z = look_rotation.z
				
				f_node.rotation = real_rotation
