extends Resource
class_name Food

var total_food: int
var food_per_day: int = 1000
var food_types: Dictionary
 
func _init() -> void:
	pass

func get_total_food() -> int:
	return total_food

func update_total_food(amount: int) -> void:
	total_food += amount
	if total_food < 0:
		total_food = 0
