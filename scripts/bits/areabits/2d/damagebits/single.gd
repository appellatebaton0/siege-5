class_name SingleDamage2D extends DamageBit2D
## Applies a set amount of damage to the target, once. 

@export var amount := 1.0

func damage() -> void:

	# Damage every health once, by the amount.
	for bit in health:
		bit.modify_health(-amount)
	
	end() # End this DamageBit.
