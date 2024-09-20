extends VBoxContainer

var population_manager = Node

var population = Population.new(5000, 5000)

var totalPopulationLabel = Label.new()
var malePopulationLabel = Label.new()
var femalePopulationLabel = Label.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	createNodeLayout()

func createNodeLayout() -> void:
	var container = VBoxContainer.new()
	container.name = "PopulationContainer"

	totalPopulationLabel.text = "Total Population: " + str(population.getTotalPopulation())
	malePopulationLabel.text = "Male Population: " + str(population.getMalePopulation())
	femalePopulationLabel.text = "Female Population: " + str(population.getFemalePopulation())

	container.add_child(totalPopulationLabel)
	container.add_child(malePopulationLabel)
	container.add_child(femalePopulationLabel)

# Called every frame. 'delta' is the elapsed time since the previous frame.
