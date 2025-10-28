class_name CastBool extends BoolValue
## Casts a value to a bool.

@export var input:Value

func value() -> bool:
	
	if input != null:
		var response = input.value()
		
		if response is int or response is bool or response is float:
			return bool(response)
	
	return false
