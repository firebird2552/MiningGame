extends Node

var controlNode: Node
var planets: Dictionary
# This file is used to manage the map, planets, and currently selected planet

func _ready():
	controlNode = get_parent().get_node("Control")
	var planets_json = load_planets()
	process_planets(planets_json)

func _process(_delta: float) -> void:
	pass

func load_planets() -> Dictionary:
	var file = FileAccess.open("res://assets/planets.json", FileAccess.READ)
	var planets_json: Dictionary = {}
	if file != null:
		var json_text = file.get_as_text()
		file.close()
		var json_parser = JSON.new()
		var parsed_error = json_parser.parse(json_text)
		if parsed_error == OK:
			planets_json = json_parser.data
		else:
			print("Failed to parse planets JSON:", parsed_error)
	else:
		print("Planets.json not found")
	return planets_json

func process_planets(planets_json: Dictionary) -> void:
	for planet_data in planets_json["planets"]:
		var planet_name = planet_data["name"]
		
		var discovered = planet_data["discovered"]

		var parent = get_parent()
		var mapGrid = parent.get_node("Control/MapGrid")
		# You can now create Planet instances from this data
		var new_planet = Planet.new(planet_data)
		planets[planet_name] = new_planet
		add_child(new_planet)
		if discovered:
			var button = Button.new()
			button.text = planet_name
			button.connect("pressed", Callable(selectPlanet).bind(planet_name))
			var container = HBoxContainer.new()
			container.add_child(button)
			mapGrid.add_child(container)
		
func selectPlanet(planet_name: String):
	if planets.has(planet_name):
		controlNode.current_planet = planet_name
	else:
		print("Planet not found: " + planet_name)		

func getPlanets() -> Dictionary:
	return planets
