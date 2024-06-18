extends MovingItemManager

@export var spawPos:Marker2D
@export var speed:float = 100
@export var pipeDistance:float = 100

@onready var random_timer = $RandomTimer

const PIPES = preload("res://Scenes/pipes.tscn")

func _ready():
	random_timer.start()
	moving_speed = speed
	should_arrange_item = false
	%GameManager.game_over.connect(stop_all)
	%GameManager.game_over.connect(stop_spawning)
	super._ready()
	random_timer.start_random()

func _on_random_timer_timeout():
	spawThePipe()
	random_timer.start_random()

func spawThePipe():
	var new_instance = PIPES.instantiate()
	if new_instance:
		init_pipes(new_instance)
		
func stop_spawning()->void:
	random_timer.stop()

func _on_limit_line_body_entered(body):
	if body is Pipes:
		body.queue_free()

func init_pipes(pipes: Pipes)-> void:
	pipes.set_speed(moving_speed)
	add_child(pipes)
	items.append(pipes)
	pipes.global_position = spawPos.global_position
	var rng = RandomNumberGenerator.new()
	rng.randomize()  # Seed the generator for more randomness
	pipes.global_position.y += rng.randf_range(-50, 50)
	pipes.set_pipe_distance(pipeDistance)
