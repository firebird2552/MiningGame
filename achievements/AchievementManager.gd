extends Node

var Toast = preload("res://Toast.tscn")
var achievements = {}  # This will hold the achievement data

func _ready():
	load_achievements()

# Load the achievements from the JSON file
func load_achievements():
	var file = FileAccess.open("res://assets/achievements.json", FileAccess.READ)
	if file != null:
		var json_text = file.get_as_text()
		file.close()
		var json_parser = JSON.new()
		var parsed_error = json_parser.parse(json_text)

		
		if parsed_error == OK:
			achievements = json_parser.data["achievements"]
		else:
			print("Failed to parse achievements JSON:", parsed_error)

# Check if an achievement is completed
func check_achievement(achievement_name: String):
	for achievement in achievements:
		if achievement.name == achievement_name and not achievement.completed:
			achievement.completed = true
			show_toast(achievement_name)  # Show the toast notification

# Show a toast notification when an achievement is unlocked
func show_toast(achievement_name: String):
	var toast = Toast.instantiate()
	toast.set_text("Achievement Unlocked: " + achievement_name)
	add_child(toast)
