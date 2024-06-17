extends MovingItemManager

@export var speed:float = 100

func _ready():
	moving_speed = speed
	%GameManager.game_over.connect(stop_all)
	super._ready()

func _on_limit_line_body_entered(body):
	if body is Background:
		move_to_the_last(body)
