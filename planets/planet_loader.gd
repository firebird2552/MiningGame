extends Node

var controlNode: Node
var current_planet: String
var planets: Dictionary = PlanetController.getPlanets()

func _ready() -> void:
    controlNode = get_parent()
    current_planet = controlNode.current_planet
    if planets:
        for planet in planets:
            createPopulationSection(planets[planet])
            # createMineSection(planet)

func _process(delta: float):
    var planet = planets[current_planet]
    # planet.population.updatePopulation(delta)
    # planet.population.updateLabels()

func createPopulationSection(planet: Planet) -> int:
    """
    Creates the population section of the planet.
    Returns success status:
        - 0: Failure
        - 1: Success
    """

    var ui_node = planet.population.getUINode()
    if planet.getName() != current_planet:
        ui_node.visible = false
    if ui_node:
        get_node("PopulationSection/PopulationManagement").add_child(ui_node)

    

    return 1

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
