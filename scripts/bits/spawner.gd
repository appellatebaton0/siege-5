class_name SpawnerBit extends Bit
## Spawns nodes from PackedScenes, with configurable intervals.

## The node to add new spawns to.
@export var parent:NodeValue
## The PackedScene to use
@export var scene:PackedSceneValue
## The position to spawn the nodes at
@export var spawn_position:Vector2Value
## The rotation to spawn the nodes with (degrees).
@export var spawn_rotation:FloatValue

## The interval between spawns.
@export var interval:FloatValue
var current_interval := -1.0 ## The current interval. When the timer reaches this, it's updated by [interval] and the timer is reset.
var timer := 0.0

## Sets a limit on how many times the node can be spawned; -1 is infinite.
@export var total_spawn_limit := -1
var total_spawns := 0
## Sets a limit on how many nodes spawned by this spawner can exist at once; -1 is infinite.
@export var concurrent_spawn_limit := -1
var spawns:Array[Node]

## Attempt to create and return a new node.
func spawn_new() -> Node:
	# Define the variables 
	var parent_v:Node
	var scene_v:PackedScene
	var position_v:Vector2
	var rotation_v:float
	
	# Attempt to set them
	if parent != null:
		parent_v = parent.value()
	else:
		parent_v = self
	
	if scene != null:
		scene_v = scene.value()
	if scene_v == null:
		return null # Can't make a node from nothing :(
	
	if spawn_position != null:
		position_v = spawn_position.value()
	elif is_class("Node2D"):
		position_v = self.global_position
	else:
		position_v = Vector2.ZERO
	
	if bot.is_class("Node2D"): ## Offset by the bot if needed
		position_v += bot.global_position
	
	if spawn_rotation != null:
		rotation_v = spawn_rotation.value()
	elif is_class("Node2D"):
		rotation_v = self.rotation
	elif bot.is_class("Node2D"):
		rotation_v = bot.rotation
	else:
		rotation_v = 0.0
	
	# Now that all the values FINALLY exist, make and return the node;
	
	var new:Node = scene_v.instantiate()
	
	parent_v.add_child(new)
	
	if new is Node2D:
		new.global_position = position_v
		new.rotation = rotation_v
	
	total_spawns += 1
	spawns.append(new)
	
	return new

## Try to get a new interval.
func renew_interval() -> void:
	if interval != null:
		var val = interval.value()
		if val != null:
			current_interval = val

func can_spawn() -> bool:
	var real_spawns:Array[Node]
	
	for spawn in spawns:
		if is_instance_valid(spawn):
			real_spawns.append(spawn)

	spawns = real_spawns
	
	
	if len(spawns) >= concurrent_spawn_limit and not concurrent_spawn_limit == -1:
		return false
	
	if total_spawns >= total_spawn_limit and not total_spawn_limit == -1:
		return false
	return true
	

func _ready() -> void:
	renew_interval()
	
	timer = current_interval

func _process(delta: float) -> void:
	
	if current_interval >= 0 and can_spawn(): # If a valid interval exists
		
		timer = move_toward(timer, 0, delta)
		
		if timer <= 0:
			spawn_new()
			
			renew_interval()
			
			timer = current_interval
		
