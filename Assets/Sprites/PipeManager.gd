extends MovingItemManager

@export var spawPos:Vector2
@export var speed:float = 100

func init():
	moving_speed = speed
	should_arrange_item = false

func _on_game_manager_game_over():
	stop_all()
