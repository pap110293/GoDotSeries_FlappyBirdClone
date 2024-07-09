extends MovingItemManager

@export var spaw_pos:Marker2D
@export var speed:float = 100
@export var pipe_distance:float = 100
@export var max_pipe_range:float = 50
@export var min_pipe_range:float = -50
@export var min_spaw_time:float = 1
@export var max_spaw_time:float = 3
@export var pipe_scene:PackedScene

@onready var random_timer = $RandomTimer

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()  # Seed the generator for more randomness
	moving_speed = speed
	should_arrange_item = false
	%GameManager.game_over.connect(stop_spawning)
	super._ready()

func _on_random_timer_timeout():
	spawThePipe()
	random_timer.start_random()

func _on_viewport_size_changed()->void:
	update_spaw_position()

func update_spaw_position()->void:
	spaw_pos.global_position.x = get_viewport().get_visible_rect().size.x + 100

func spawThePipe():
	var new_instance = pipe_scene.instantiate()
	if new_instance:
		init_pipes(new_instance)
		
func stop_spawning()->void:
	random_timer.stop()

func start_spawning()->void:
	random_timer.start_random()
	random_timer.minValue = min_spaw_time
	random_timer.maxValue = max_spaw_time

func _on_limit_line_body_entered(body):
	if body is Pipes:
		body.queue_free()

func init_pipes(pipes: Pipes)-> void:
	pipes.set_speed(moving_speed)
	add_child(pipes)
	items.append(pipes)
	pipes.global_position = spaw_pos.global_position
	pipes.global_position.y += rng.randf_range(min_pipe_range, max_pipe_range)
	pipes.set_pipe_distance(pipe_distance)
	pipes.start_moving()
	
func _on_game_start():
	start_spawning()
	super._on_game_start()
