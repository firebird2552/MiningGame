extends Node
class_name Planet

var planet_name: String
var unlocked: bool
var discovered: bool
var resources: Dictionary
var buildings: Dictionary
var planet_time: PlanetTime

var planet_data: Dictionary
var population: Population
var food: Food
var seasons: SeasonManager

var current_day = 1
var current_month = 1
var current_week = 1
var current_year = 1
var current_season: PlanetSeason

var year_label: Label
var month_label: Label
var week_label: Label
var day_label: Label
var season_label:Label

var year_progress_bar: ProgressBar
var month_progress_bar: ProgressBar
var week_progress_bar: ProgressBar
var day_progress_bar: ProgressBar
var season_progress_bar: ProgressBar
var elapsed_day: float = 0
func _init(p_data: Dictionary):
	food = Food.new()
	var p_seasons = p_data["seasons"]
	seasons = SeasonManager.new(p_seasons)
	planet_data = p_data
	planet_name = planet_data["name"]
	unlocked = planet_data["unlocked"]
	discovered = planet_data["discovered"]
	resources = planet_data["resources"]
	buildings = planet_data["buildings"]
	population = Population.new(500, 500)
	var time_data = planet_data["time"]
	planet_time = PlanetTime.new(
		time_data["day"],
		time_data["week"],
		time_data["month"],
		time_data["year"]
		)
	planet_time.connect("day_passed", planet_tick)
	planet_time.connect("year_passed", new_year)
	current_season = seasons.get_current_season(current_month)

func planet_tick():
	print("A day has passed on " + planet_name)
	current_day += 1
	population.update_population(planet_time.getYear())

	var time_data = calculate_time_percentages(current_day)

	print("Year Percent: " + str(time_data["year"]))
	print("Month Percent: " + str(time_data["month"]))
	print("Week Percent: " + str(time_data["week"]))

	year_progress_bar.value = time_data["year"]
	month_progress_bar.value = time_data["month"]
	week_progress_bar.value = time_data["week"]

func new_week() -> void:
	print("A new week has begun on " + planet_name)
	current_week += 1

func new_month() -> void:
	print("A new month has begun on " + planet_name)
	current_month += 1

func new_year() -> void:
	print("A new year has started on " + planet_name)
	current_year += 1
	current_month = 1
	current_week = 1

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

func update_planet(delta:float) -> void:
	elapsed_day = planet_time.update_time(delta)

func update_planet_info() -> void:
	day_progress_bar.value = elapsed_day
	


	year_label.text = "Year: " + str(current_year)
	month_label.text = "Month: " + str(current_month)
	week_label.text = "Week: " + str(current_week)
	day_label.text = "Day: " + str(current_day)
	season_label.text = current_season.getName().capitalize()
	

func create_planet_info() -> void:
	var parent = get_parent().get_parent()
	print(parent)
	var planet_node = parent.get_node("Control/Planet/PlanetInformation")
	year_progress_bar = planet_node.get_node("YearProgressBar")
	month_progress_bar = planet_node.get_node("MonthProgressBar")
	week_progress_bar = planet_node.get_node("WeekProgressBar")
	day_progress_bar = planet_node.get_node("DayProgressBar")
	season_progress_bar = planet_node.get_node("SeasonProgressBar")

	year_progress_bar.show_percentage = false
	month_progress_bar.show_percentage = false
	week_progress_bar.show_percentage = false
	day_progress_bar.show_percentage = false
	season_progress_bar.show_percentage = false


	year_progress_bar.max_value = 100
	month_progress_bar.max_value = 100
	week_progress_bar.max_value = 100
	day_progress_bar.max_value = 60

	year_label = year_progress_bar.get_node("Label")
	year_label.text = "Year: " + str(current_year)
	month_label = month_progress_bar.get_node("Label")
	month_label.text = "Month: " + str(current_month)
	week_label = week_progress_bar.get_node("Label")
	week_label.text = "Week: " + str(current_week)
	day_label = day_progress_bar.get_node("Label")
	day_label.text = "Day: " + str(current_day)
	season_label = season_progress_bar.get_node("Label")
	season_label.text = str(seasons.get_current_season(current_month).getName().capitalize())
	
func calculate_time_percentages(elapsed_days: int) -> Dictionary:
	var percentages = {}

	var days_in_year = planet_time["year"]
	var days_in_month = planet_time["month"]
	var days_in_week = planet_time["week"]


	# Calculate year percentage
	var days_in_current_year = elapsed_days % days_in_year
	percentages.year = float(days_in_current_year) / days_in_year * 100.0

	# Calculate month percentage
	var days_in_current_month = days_in_current_year % days_in_month
	percentages.month = float(days_in_current_month) / days_in_month * 100.0

	# Calculate week percentage
	var days_in_current_week = days_in_current_month % days_in_week
	percentages.week = float(days_in_current_week) / days_in_week * 100.0

	return percentages