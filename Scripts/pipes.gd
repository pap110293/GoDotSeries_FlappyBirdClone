extends MovingItem

@onready var pipe_top = $PipeTop
@onready var pipe_bot = $PipeBot

func set_pipe_distance(pipe_distance:float)->void:
	pipe_top.global_position.x += pipe_distance/2
	pipe_bot.global_position.x += pipe_distance/2
