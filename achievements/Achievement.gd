extends Resource
class_name Achievement

# Properties for the achievement
var name: String
var description: String
var completed: bool = false
var achievement_type: String  # "global" or "local"
var target: String  # The item tied to the achievement (e.g., "steel" or "zentrite_mine")
var quantity: int  # The quantity needed to unlock the achievement
var prerequisite: String  # The prerequisite achievement
var next_level: String  # Next achievement level in progression
var hidden: bool = true  # If true, the achievement is mysterious

# Constructor
func _init(p_name: String, p_description: String, p_type: String, p_target: String, p_quantity: int, p_prerequisite: String = "", p_next_level: String = "", p_hidden: bool = true):
	name = p_name
	description = p_description
	achievement_type = p_type
	target = p_target
	quantity = p_quantity
	prerequisite = p_prerequisite
	next_level = p_next_level
	hidden = p_hidden

# Check if the achievement can be unlocked
func can_unlock(current_quantity: int) -> bool:
	return current_quantity >= quantity and not completed

# Unlock the achievement
func unlock() -> void:
	completed = true
	hidden = false  # Reveal the achievement

# Getters
func get_name() -> String:
	return name

func get_description() -> String:
	return hidden and "???" or description  # Return "???" if still hidden

func is_hidden() -> bool:
	return hidden

func get_achievement_type() -> String:
	return achievement_type

func get_target() -> String:
	return target

func get_quantity() -> int:
	return quantity

func get_prerequisite() -> String:
	return prerequisite

func get_next_level() -> String:
	return next_level

func is_completed() -> bool:
	return completed
