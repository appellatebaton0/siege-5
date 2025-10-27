class_name ExampleAreaBit extends AreaBit
## What do I do?

## Run when a body / area enters the Master
func on_body_entered(_body:Node) -> void:
	pass
func on_area_entered(_area:Node) -> void:
	pass

## Run when a body / area exits the Master
func on_body_exited(_body:Node) -> void:
	pass
func on_area_exited(_area:Node) -> void:
	pass

## Always run; effectively _process with inputs for overlapping bodies / areas.
func while_overlapping_bodies(_bodies:Array[Node], _delta:float) -> void:
	pass
func while_overlapping_areas(_area:Array[Node], _delta:float) -> void:
	pass
