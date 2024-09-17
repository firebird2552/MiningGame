extends BaseResource
class_name Alloy

var recipe: Dictionary
var smelting_speed: float

func _init(p_name: String,p_recipe: Dictionary, p_base_value: float = 0.0,  p_smelting_speed: float = 1.0):
    super._init(p_name, p_base_value)
    recipe = p_recipe
    smelting_speed = p_smelting_speed

func getRecipe() -> void:
    pass