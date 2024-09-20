extends Resource
class_name PlanetTime

signal day_passed
signal week_passed
signal month_passed
signal year_passed


var day: int
var week: int
var month: int
var year: int

var elapsed_time: float = 0.0
var elapse_days: int = 0

func _init(p_day: int, p_week: int, p_month: int, p_year: int):
    day = p_day
    week = p_week
    month = p_month
    year = p_year

func update_time(delta: float) -> float:
    elapsed_time += delta

    if elapsed_time >= day:
        elapsed_time -= day
        elapse_days += 1
        emit_signal("day_passed")

        if elapse_days % week == 0:
            emit_signal("week_passed")

        if elapse_days % month == 0:
            emit_signal("month_passed")
        if elapse_days % year == 0:
            emit_signal("year_passed")

    return elapsed_time 

func getYear() -> int:
    """
    Returns the number of seconds that equals a year
    """

    return year 
func getDaysInAYear() -> int:
    var days_in_a_year = year/day
    print("Days in a year" + str(days_in_a_year))

    return days_in_a_year

func getWeek() -> int:
    return week

func getMonth() -> int:
    return month

func getDay() -> int:
    return day
