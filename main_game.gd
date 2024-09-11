extends Control

# Load constants
var Constants = preload("res://constants.gd")

# Ready function to set window position and fullscreen mode
func _ready():
	var monitor_count = DisplayServer.get_screen_count()
	var found_portrait = false

	for monitor_index in range(monitor_count):
		var monitor_size = DisplayServer.screen_get_size(monitor_index)
		var monitor_position = DisplayServer.screen_get_position(monitor_index)

		if monitor_size.y > monitor_size.x:
			print("Monitor ", monitor_index, " is in portrait mode")
			var window_size = DisplayServer.window_get_size()
			var window_position = monitor_position + (monitor_size - window_size) / 2
			DisplayServer.window_set_position(window_position)
			DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN)
			found_portrait = true
			break

	if not found_portrait:
		print("No portrait monitors found, defaulting to primary monitor")
		var primary_position = DisplayServer.screen_get_position(0)
		DisplayServer.window_set_position(primary_position)
		DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN)
