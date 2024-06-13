extends Node

@onready var game_over_timer = $GameOverTimer
signal game_over

func _on_flappy_bird_died():
	game_over_timer.start()
	game_over.emit()


func _on_game_over_timer_timeout():
	get_tree().reload_current_scene()
