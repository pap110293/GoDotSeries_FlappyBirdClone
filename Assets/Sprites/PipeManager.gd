extends MovingItemManager

@export var spawPos:Marker2D
@export var speed:float = 100

@onready var random_timer = $RandomTimer

const PIPES = preload("res://Scenes/pipes.tscn")

func _ready():
	random_timer.start()
	moving_speed = speed
	should_arrange_item = false
	%GameManager.game_over.connect(stop_all)
	super._ready()
	random_timer.start_random()

func _on_random_timer_timeout():
	spawThePipe()
	random_timer.start_random()

func spawThePipe():
	var pipe_instance = PIPES.instantiate()
	if pipe_instance is Pipes:
		pipe_instance.set_speed(moving_speed)
		add_child(pipe_instance)
		items.append(pipe_instance)
		pipe_instance.global_position = spawPos.global_position
		

func _on_limit_line_body_entered(body):
	if body is Pipes:
		body.queue_free()
