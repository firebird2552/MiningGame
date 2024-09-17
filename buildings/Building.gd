extends Node
class_name Building

var building_name: String
var construction_time: float
var construction_cost: Array = []
var building_count: int
var constructionInProgress:bool = false

func _init(p_name: String, p_construction_cost: Dictionary, p_construction_time: float= 1, p_building_count: int = 0):
    building_name = p_name
    for ingredient in p_construction_cost:
        addConstructionIngredient(ingredient)
    construction_time = p_construction_time
    building_count = p_building_count

func addConstructionIngredient(ingredient: Ingredient):
    construction_cost.append(
        {
            "name": ingredient.getName(),
            "amount": ingredient.getAmount()
        }
    )

func getBuildingCount() -> int:
    return building_count

func incrementBuildingCount(quantity: int = 1):
    building_count += quantity

func getConstructionCost() -> Array:
    return construction_cost

func getConstructionTime() -> float:
    return construction_time

func getName() -> String:
    return building_name

func canBuild(available_resources: Dictionary) -> bool:
    for ingredient in construction_cost:
        if not available_resources.has(ingredient.name) or available_resources[ingredient.name] < ingredient.amount:
            return false
    return true

func build(available_resources: Dictionary):
    if canBuild(available_resources):
        for ingredient in construction_cost:
            available_resources[ingredient.name] -= ingredient.amount
        
        constructionInProgress = true
        var timer = Timer.new()
        timer.wait_time = construction_time
        add_child(timer)
        timer.connect("timeout", onConstructionComplete)
        timer.start()
        return true
    return false

func onConstructionComplete():
    constructionInProgress = false
    incrementBuildingCount()