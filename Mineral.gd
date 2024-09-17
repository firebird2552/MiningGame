extends BaseResource
class_name Mineral

# Mineral-specific properties
var mining_rate: float  # Rate at which the mineral is mined
var available_amount: int  # Amount of this mineral available for mining

# Constructor
func _init(p_name: String, p_base_value: int, p_mining_rate: float, p_available_amount: int):
    super._init(p_name, p_base_value)
    mining_rate = p_mining_rate
    available_amount = p_available_amount

func getMiningRate() -> float:
    return mining_rate

func getAvailableAmount() -> int:
    return available_amount

# Method to mine the mineral
func mine(delta: float) -> int:
    var mined_amount = int(mining_rate * delta)
    
    # Ensure we don't mine more than what's available
    mined_amount = min(mined_amount, available_amount)
    
    available_amount -= mined_amount
    return mined_amount
