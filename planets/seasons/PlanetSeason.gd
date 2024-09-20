extends Resource
class_name PlanetSeason

var season_name: String
var season_start: int
var season_end: int
var duration: int
var elapsed_duration: int = 0
var hunting_effect: float = 1.0
var gathering_effect: float = 1.0

func _init(p_name: String, p_season_data: Dictionary):
    season_name = p_name
    season_start = p_season_data["start"]
    season_end = p_season_data["end"]

func getStartingMonth() -> int:
    return season_start

func getEndingMonth() -> int:
    return season_end

func isMonthInSeason(month: int) -> bool:
# Check if the season wraps around the end of the year
    if season_start > season_end:
        # Month must be greater than or equal to the start month OR less than the end month
        return month >= season_start or month < season_end
    else:
        # Normal season where the start month is less than the end month
        return month >= season_start and month < season_end

func getName()-> String:
    return season_name

func getElapsedDuration()-> int:
    return elapsed_duration

func getHuntingEffect()-> float:
    return hunting_effect

func getGatheringEffect()-> float:
    return gathering_effect

func getRemainingDuration()-> int:
    return duration - elapsed_duration

func getSeasonDuration()-> int:
    return duration

func incrementElapsedDuration() -> bool:
    elapsed_duration += 1
    if elapsed_duration > duration:
        elapsed_duration = 0
        return true
    return false

func applyHuntingEffect(p_effect: float) -> void:
    hunting_effect *= p_effect

func applyGatheringEffect(p_effect: float) -> void:
    gathering_effect *= p_effect
