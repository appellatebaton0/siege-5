class_name BitValue extends Value
## Gets the value of a ValueBit, from a Bot.

## The bot to get from.
@export var bot:NodeValue
## The id of the ValueBit to pull from.
@export var id:String

func _ready() -> void:
	if bot == null:
		for child in get_children():
			if child is NodeValue:
				bot = child

func value() -> Variant:
	# Do all the necessary checks and look for a valid bit.
	if bot != null:
		var bot_node = bot.value()
		if bot_node is Bot:
			for bit in bot_node.get_children():
				if bit is ValueBit:
					if bit.id == id:
						
						return bit.value # If found, return that bit's value.
	return null
