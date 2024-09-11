extends Node


# Alloy data
var alloys = {
    "steel": 0,
    "duronite": 0
}

# Alloy recipes
var alloyRecipes = {
    "steel": {
        "iron": 2,
        "carbon": 1
    },
	"duronite": {
		"durium": 3,
		"zentrite": 2
	}
}
var minerals: Dictionary;
var mineralsNode: Node;
var mineralManagementNode: Node;

func _ready() -> void:
    var parent: Node = get_parent()
    mineralManagementNode = parent.get_node("MineralsManagement")
    mineralsNode = parent.get_node("MineralsManagement/Minerals")
    minerals = mineralsNode.minerals

# Store smelting tasks for each smelter
var smeltTimers = {}

var smelters = {
    "steel": {
        "count": 0,
        "busy": false,
        "timer": null
    },
    "duronite": {
        "count": 0,
        "busy": false,
        "timer": null
    }
}

# Function to start batch smelting
func smeltAlloy() -> void:
    for smelter in smelters:
        if smelters[smelter]["busy"]:
            continue
        var progressContainerString = "BuildingMenu/AlloySmelters/" + smelter.capitalize() + "Smelters/ProgressContainer"
        var progressContainer = get_node(progressContainerString)
        var recipe = alloyRecipes[smelter]
        var smelterCount = smelters[smelter]["count"]


        if smelterCount <= 0:
            continue

        var craftCount: int = 0
        for craftingMaterial in recipe:
            var newCraftCount = int(minerals[craftingMaterial] / recipe[craftingMaterial])
            if newCraftCount < craftCount or craftCount == 0:
                craftCount = min(newCraftCount, smelterCount)

        if craftCount == 0:
            continue

        # Deduct resources for the batch crafting
        for craftingMaterial in recipe:
            minerals[craftingMaterial] -= recipe[craftingMaterial] * craftCount

        # Create a new timer for the batch smelting task
        var timer = Timer.new()
        timer.wait_time = 10  # Adjust to represent the batch time (e.g., 10 seconds)
        timer.one_shot = true
        add_child(timer)

        # Create a progress bar for the entire batch
        var progress_bar = ProgressBar.new()
        progress_bar.max_value = 100
        progress_bar.value = 0
        progressContainer.add_child(progress_bar)

        # Create a label to display the batch information
        var progress_label = Label.new()
        progress_label.text = "Smelting " + str(craftCount) + " items"
        progressContainer.add_child(progress_label)

        # Add smelting task to the list (batch processing)
        if not smeltTimers.has(smelter):
            smeltTimers[smelter] = {"tasks": []}

        smeltTimers[smelter]["tasks"].append({
            "timer": timer,
            "craftCount": craftCount,
            "progressBar": progress_bar,
            "elapsed": 0,
            "label": progress_label
        })

        smelters[smelter]["busy"] = true
        timer.start()

# Function to update smelting progress (batch processing)
func checkAlloyCompleteStatus(delta):
    var tasksToRemove = []
    for smelter in smeltTimers:
        for task in smeltTimers[smelter]["tasks"]:
            var timer = task["timer"]

            # If the timer is still running, update the progress bar for the batch
            if not timer.is_stopped():
                task["elapsed"] += delta
                task["progressBar"].value = min((task["elapsed"] / timer.wait_time) * 100, 100)
                continue

            # When the batch is complete, add crafted items to inventory
            if alloys.has(smelter):
                alloys[smelter] += task["craftCount"]
            else:
                alloys[smelter] = task["craftCount"]

            print("Batch smelting complete for ", smelter, ": ", task["craftCount"], " units")

            # Mark the smelter as no longer busy
            smelters[smelter]["busy"] = false

            # Remove the progress bar, label, and timer
            task["progressBar"].queue_free()
            task["label"].queue_free()
            task["timer"].queue_free()

            tasksToRemove.append({"smelter": smelter, "task": task})

    for entry in tasksToRemove:
        smeltTimers[entry["smelter"]]["tasks"].erase(entry["task"])

func _process(delta: float) -> void:
    smeltAlloy()
    checkAlloyCompleteStatus(delta)	


func updateMinerals() -> void:
    for alloy in alloys:
        var alloyName = alloy.capitalize()
        var nodeName = "Alloys/" + alloyName + "/" + alloyName + "Count"
        get_node(nodeName).text = str(alloys[alloy])
    for smelter in smelters:
        var smelterName = smelter.capitalize()
        var nodeName = "AlloySmelters/" + smelterName + "Smelters/HBoxContainer/" + smelterName + "SmelterCount"
        get_node(nodeName).text = str(smelters[smelter]["count"])

