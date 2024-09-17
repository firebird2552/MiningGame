extends Node

var mines = {
	"stone": 1,
	"carbon": 1,
	"iron": 1,
	"crystals": 0,
	"durium": 0,
	"zentrite": 0,
	"argonite": 0,
	"argarium": 0
}

func addMine(mine: String):
	mines[mine] += 1
	
var mineNodes: Dictionary;
var ironMineCount: Node;
var duriumMineCount: Node;
var zentriteMineCount: Node;
func _ready() -> void:
	var mineNode = get_node("MinesDisplay/Mines")
	for mine in mines:
		var mineralName: String = mine.capitalize()
		var containerNodeName: String = mineralName + "Mines";
		var mineLabel: String = mineralName + "MineLabel";
		var mineralCountLabelName: String = mineralName + "MineCount"
		var container = HBoxContainer.new()
		container.name = containerNodeName
		var label = Label.new()
		label.name = mineLabel
		label.text = mineralName + ": "
		container.add_child(label)
		var count = Label.new()
		count.name = mineralCountLabelName
		count.text = str(mines[mine])
		mineNodes[mine] = count
		container.add_child(count)
		mineNode.add_child(container)

func _process(_delta: float) -> void:
	for mine in mines:
		mineNodes[mine].text = str(mines[mine])
