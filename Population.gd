extends Resource
class_name Population

var total_population: int = 0
var male_population: int = 0
var female_population: int = 0
var birth_rate: float = 0.45

var resource_limit: int = 99999999999

var birth_accumulator: float = 0.0

func updatePopulation(delta: float) -> void:
    if male_population and female_population:
        var annual_births: float = total_population * birth_rate
        var possible_births = annual_births * (delta/365.0)

        birth_accumulator += possible_births
        if birth_accumulator >= 1.0:
            var births = int(birth_accumulator)

            birth_accumulator -= births

            if total_population + births <= resource_limit:
                distribute_births(births)
            else:
                distribute_births(resource_limit - total_population)

func distribute_births(births:int):
    if births == 1:
        if randi() % 2 ==0:
            male_population += 1
        else:
            female_population += 1
    else:
        var male_births: int = births / 2
        var female_births: int = births - male_births

        male_population += male_births
        female_population += female_births
    setTotalPopulation()

func _init(p_male_population: int, p_female_population: int):
    male_population = p_male_population
    female_population = p_female_population
    setTotalPopulation()

func getTotalPopulation() -> int:
    return total_population

func getMalePopulation() -> int:
    return male_population

func getFemalePopulation() -> int:
    return female_population

func setMalePopulation(p_male_pop: int) -> void:
    male_population = p_male_pop
    setTotalPopulation()

func adjustMalePopulation(amount: int, decrement: bool) -> void:
    if decrement:
        male_population -= amount
    else:
        male_population += amount
    setTotalPopulation()

func setFemalePopulation(p_female_pop: int) -> void:
    female_population = p_female_pop
    setTotalPopulation()

func adjustFemalePopulation(amount: int, decrement: bool) -> void:
    if decrement:
        female_population -= amount
    else:
        female_population += amount
    setTotalPopulation()

func setTotalPopulation() -> void:
    total_population = male_population + female_population
