class_name ValueModifierBit extends Bit
## Changes the value of a ValueBit to a new value.

## The Bot to change the value on.
@export var target:NodeValue
## The ID of the ValueBit IN the bot to look for.
@export var value_id:String
## The value to change it to.
@export var new_value:Value
## Whether to constantly modify.
@export var constant := false
## Modifies if the condition is true.
@export var condition:BoolValue

## For signals that are STUPID.
func modify_val(_value):
	modify()

func _process(_delta: float) -> void:
	if constant or (condition != null and condition.value()):
		modify()

## Can be attached to signals >:)
func modify():
	if target != null and new_value != null:
		
		var target_node = target.value()
		var next_value = new_value.value()
		
		if target_node is Bot:
			if target_node is ValueBit:
				target_node.value = next_value
				return 2
			
			for child in target_node.get_children():
				if child is ValueBit:
					if child.id == value_id:
						child.value = next_value
						return 1
	return -1
