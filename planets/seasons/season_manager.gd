extends Node
class_name SeasonManager

signal season_changed(new_season: String)

var available_seasons: Array
var current_season: PlanetSeason

func _init(p_season_data: Dictionary):
    for season in p_season_data:
        available_seasons.append(PlanetSeason.new(season, p_season_data[season]))

func get_current_season(p_current_month: int):
    for season in available_seasons:
        if season.isMonthInSeason(p_current_month):
            current_season = season
            return current_season
    return null
    

func change_season()-> void:
    var season_index = available_seasons.find(current_season)
    season_index = (season_index + 1) % available_seasons.size()
    current_season = available_seasons[season_index]
    emit_signal("season_changed", current_season.getName())

func tickSeason() -> void:
    # Update season based on game time
    # Each season is X amount of days and a day is defined as x number of seconds which is defined at the planet level
    # Example: Each season is 30 days long, and a day is 60 seconds long
    # Update current_season based on game time
    var season_ended = current_season.incrementElapsedDuration()
    if season_ended:
        change_season()

    