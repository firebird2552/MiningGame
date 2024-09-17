extends Resource
class_name CraftingRecipe

var ingredients: Array = []
var craft_quantity: int

func _init(p_ingredients: Dictionary, p_craft_quantity: int = 1):
    for ingredient in p_ingredients:
        addIngredient(ingredient)
    craft_quantity = p_craft_quantity

func addIngredient(ingredient: Ingredient) -> void:
    ingredients.append({
        "ingredient": ingredient.name,
        "quantity": ingredient.quantity
    })
func getIngredients() -> Array:
    return ingredients

func getCraftQuantity() -> int:
    return craft_quantity

func canCraft(available_resources: Dictionary) -> bool:
    for ingredient in ingredients:
        if available_resources.has(ingredient) and available_resources[ingredient] >= ingredient.quantity * craft_quantity:
            continue
        return false
    return true
