extends MovingItemManager

@export var speed:float = 100

func _on_limit_line_body_entered(body):
	if body is Background:
		move_to_the_last(body)

func init():
	moving_speed = speed

func _on_game_manager_game_over():
	stop_all()
