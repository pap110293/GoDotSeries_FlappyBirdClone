extends Timer

@export var minValue:float = 0.1
@export var maxValue:float = 1
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()  # Seed the generator for more randomness

func start_random():
	wait_time = rng.randf_range(minValue, maxValue)
	start()
