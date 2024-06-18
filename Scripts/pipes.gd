extends MovingItem

class_name Pipes

@onready var pipe_top = $PipeTop
@onready var pipe_bot = $PipeBot

func set_pipe_distance(pipe_distance:float)->void:
	pipe_top.global_position.y += pipe_distance/2
	pipe_bot.global_position.y -= pipe_distance/2
