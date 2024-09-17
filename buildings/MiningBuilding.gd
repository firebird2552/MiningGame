extends Building
class_name MiningBuilding

var mineral: Mineral  # The mineral this building is tied to
var mining_efficiency: float  # Mining multiplier

# Constructor
func _init(p_name: String, p_construction_cost: Dictionary, p_construction_time: int,  p_mineral: Mineral, p_mining_efficiency: float, p_building_count: int = 0):
    super._init(p_name, p_construction_cost, p_construction_time, p_building_count )
    mineral = p_mineral
    mining_efficiency = p_mining_efficiency

