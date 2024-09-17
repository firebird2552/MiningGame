extends Node

var controlNode: Node
var current_planet: String
var planets: Dictionary = PlanetController.getPlanets()

func _ready() -> void:
    controlNode = get_parent()
    current_planet = controlNode.current_planet
    if planets: 
        createMineSection(planets[current_planet])

func createMineSection(planet:Planet):
    var mineralSection = VBoxContainer.new()
    add_child(mineralSection)

    pass

func createSmelterySection():
    pass

func createTradingPostSection():
    pass

func createFactorySection():
    pass

func createResearchCenterSection():
    pass

func createDefenseSection():
    pass
