extends Timer

@export var min:float = 0.1
@export var max:float = 1

func start_random():
	var random_value = get_random_float(min, max)
	wait_time = random_value
	start()

func get_random_float(min: float, max: float) -> float:
	var rng = RandomNumberGenerator.new()
	rng.randomize()  # Seed the generator for more randomness
	return rng.randf_range(min, max)
