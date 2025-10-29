@abstract class_name DamageBit3D extends AreaBit3D
## Runs its damage function once applied, and can be applied
## by signal or when its area collides with something.

## Whether to damage something when this Damage's area collides with it.
@export var applies_on_contact := false
## Whether to damage something constantly when this Damage's area is collided with it.
@export var applies_while_contacting := true

## Whether this instance is on something that needs to be damaged
var applied := false

## The HealthBits of the bot this damage is applied to.
var health:Array[HealthBit]

func get_target_bot(from:Node) -> Bot:
	
	# Search parents 3 layers up.
	var with = from.get_parent()
	for i in range(2):
		if with is Bit:
			return with.bot
		elif with is Bot:
			return with
		
		with = with.get_parent()
	
	# Search children and grandchildren for a reference.
	for child in from.get_children():
		if child is Bit:
			return child.bot 
		else:
			for grand in child.get_children():
				if grand is Bit:
					return grand.bot 
	
	return null

## Run when a body / area enters the Master
func on_body_entered(body:Node) -> void:
	if applies_on_contact:
		apply(get_target_bot(body)) # If can and should, apply on contact.
func on_area_entered(area:Node) -> void:
	if applies_on_contact:
		apply(get_target_bot(area)) # If can and should, apply on contact.

## Always run; effectively _process with inputs for overlapping bodies / areas.
func while_overlapping_bodies(bodies:Array[Node], _delta:float) -> void:
	if applies_while_contacting:
		for body in bodies:
			apply(get_target_bot(body))
func while_overlapping_areas(areas:Array[Node], _delta:float) -> void:
	if applies_while_contacting:
		for area in areas:
			apply(get_target_bot(area))

## Applies this damage to a bot.
func apply(to:Bot = bot):
	
	if to == null:
		return
	
	# Duplicate this damage
	var new = duplicate()
	
	# Reparent it to [to].
	if new.get_parent() != null:
		new.reparent(to)
	else:
		to.add_child(new)
	
	# Tell it it's an active damager, and update its bot.
	new.applied = true
	new.bot = new.get_bot()

func _process(_delta: float) -> void:
	if applied:
		
		# If haven't yet, load the HealthBits of the current bot into [health]
		if len(health) <= 0:
			for bit in scan_bot("HealthBit", false):
				if bit is HealthBit:
					health.append(bit)
		
		# Apply this DamageBit's damage.
		damage()

## Should be run by the DamageBit when it's DONE damaging.
func end() -> void:
	queue_free()

## What to do to the bot when applied, or specifically the health.
@abstract func damage() -> void
