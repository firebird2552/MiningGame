extends Resource
class_name BaseResource

var name: String
var base_value: float
func _init(p_name: String, p_base_value: float = 0.0):
    name = p_name
    base_value = p_base_value

func getName() -> String:
    return name

func getBaseValue() -> float:
    return base_value