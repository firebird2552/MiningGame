extends Resource
class_name Population

var total_population: int = 0
var male_population: int = 0
var female_population: int = 0
var birth_rate: float = 0.45

var resource_limit: int = 99999999999

var birth_accumulator: float = 0.0

var populationUINode: Node

var totalPopLabel = Label.new()
var malePopLabel = Label.new()
var femalePopLabel = Label.new()


func update_population(p_year_length: int) -> void:
    if male_population and female_population:
        var annual_births: float = total_population * birth_rate
        print("Possible Annual Births: " + str(annual_births))
        var possible_births: int = annual_births / (p_year_length)
        print("Possible Births: " + str(possible_births))
        
        if possible_births:

            if total_population + possible_births <= resource_limit:
                distribute_births(possible_births)
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
    createUILayout()
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

func createUILayout() -> void:
    """
    This function creates a UI layout for displaying population statistics.
    Returns:
        Node: The UI layout containing population statistics.
    """
    var container = VBoxContainer.new()

    totalPopLabel.text = "Total Population: %s" % total_population
    malePopLabel.text = "Male Population: %s" % male_population
    femalePopLabel.text = "Female Population: %s" % female_population
    container.add_child(totalPopLabel)
    container.add_child(malePopLabel)
    container.add_child(femalePopLabel)

    populationUINode = container

func getUINode() -> Node:
    return populationUINode

    
func updateLabels() -> void:
    totalPopLabel.text = "Total Population: %s" % total_population
    malePopLabel.text = "Male Population: %s" % male_population
    femalePopLabel.text = "Female Population: %s" % female_population