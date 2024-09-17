extends Resource
class_name Ingredient

var name: String
var quantity: float

func _init(p_name: String, p_quantity: float = 1):
    name = p_name
    quantity = p_quantity

func getName() -> String:
    return name

func getQuantity() -> float:
    return quantity