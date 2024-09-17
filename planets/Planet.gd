extends Node
class_name Planet

var planet_name: String
var unlocked: bool
var discovered: bool
var resources: Dictionary
var buildings: Dictionary
var planet_time: PlanetTime

var planet_data: Dictionary

func _init(p_data):
	planet_data = p_data
	planet_name = planet_data["name"]
	unlocked = planet_data["unlocked"]
	discovered = planet_data["discovered"]
	resources = planet_data["resources"]
	buildings = planet_data["buildings"]
	var time_data = planet_data["time"]
	planet_time = PlanetTime.new(
		time_data["day"],
		time_data["week"],
		time_data["month"],
		time_data["year"]
		)

	print("""
	Planet Name: %s
	Unlocked: %s
	Discovered: %s
	Seconds in a 
	Day: %s
	Week: %s
	Month: %s
	Year: %s


	""" % [planet_name, str(unlocked), str(discovered), str(planet_time.getDay()),str(planet_time.getWeek()),str(planet_time.getMonth()),str(planet_time.getYear        ())]
		)

func getName() -> String:
	return planet_name

func isUnlocked() -> bool:
	return unlocked

func toggleUnlock() -> void:
	unlocked =! unlocked

func discover() -> void:
	discovered = true

func isDiscovered() -> bool:
	return discovered

func getResources() -> Dictionary:
	return resources
	
func addResource(mineral: Mineral, amount: int):
	if not resources.has(mineral.name):
		resources[mineral.name] = {"definition": mineral, "amount": amount}
	else:
		print("Resource " + mineral.name + " Already exists on this planet!")

func getBuildings() -> Dictionary:
	return buildings

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
