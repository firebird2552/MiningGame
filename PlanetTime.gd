extends Resource
class_name PlanetTime

var day: int
var week: int
var month: int
var year: int

var elapsed_time: float = 0.0

func _init(p_day: int, p_week: int, p_month: int, p_year: int):
    day = p_day
    week = p_week
    month = p_month
    year = p_year

func update_time(delta: float) -> bool:
    elapsed_time += delta

    if elapsed_time >= day:
        elapsed_time -= day
        return true
    return false

func getYear() -> int:
    """
    Returns the number of seconds that equals a year
    """

    return year 

func getWeek() -> int:
    return week

func getMonth() -> int:
    return month

func getDay() -> int:
    return day