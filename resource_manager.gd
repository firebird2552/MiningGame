# resource_manager.gd
extends Node

var Constants = preload("res://constants.gd")

var mineManagerNode: Node;
var mines: Dictionary;
var minerals = {
	"stone": 0,
	"carbon": 0,
	"iron": 0,
	"crystals": 0,
	"durium": 0,
	"zentrite": 0,
	"argonite": 0,
	"argarium": 0
}
var mineralNodes: Dictionary;
func _ready() -> void:
	mineManagerNode = get_parent()
	mines = mineManagerNode.mines


	for mineral in minerals:
		var mineralName = mineral.capitalize()
		var mineralContainerName = mineralName + "Container"
		var mineralLabelName = mineralName + "Label"
		var mineralCountName = mineralName + "Amount"

		var container = HBoxContainer.new()
		container.name = mineralContainerName
		var label = Label.new()
		label.name = mineralLabelName
		label.text = mineralName

		var amountLabel = Label.new()
		amountLabel.name = mineralCountName
		amountLabel.text = str(minerals[mineral])
		mineralNodes[mineral] = amountLabel
		container.add_child(label)
		container.add_child(amountLabel)

		add_child(container)

	

var mine_accumulators = {
	'stone': 0.0,
	'carbon': 0.0,
	'iron': 0.0,
	'durium': 0.0,
	'zentrite': 0.0
}

# Function to handle resource mining in batches
func mineResources(delta: float) -> void:
	for mine_type in mines:
		if mine_type not in mine_accumulators:
			continue
		mine_accumulators[mine_type] += delta
		var rate = Constants.MINING_RATES[mine_type]
		if mine_accumulators[mine_type] >= 1.0 / rate:
			var num_mines = mines[mine_type]
			minerals[mine_type] += num_mines
			mine_accumulators[mine_type] = 0.0
# Function to handle resource mining
		
func _process(delta: float) -> void:
	mineResources(delta)
		
	for mineral in minerals:
		mineralNodes[mineral].text = str(minerals[mineral])
		# if has_node(nodeName):
		# 	var node = get_node(nodeName)
		# 	node.text = str()
