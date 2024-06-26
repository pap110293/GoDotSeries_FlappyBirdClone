extends Node2D

class_name	MovingItem

var move_speed:float = 0
var is_moving = false;

func _physics_process(delta):
	if is_moving:
		global_position.x += -move_speed * delta

func set_speed(new_speed:float):
	move_speed = new_speed

func stop_moving()->void:
	is_moving = false

func start_moving()->void:
	is_moving = true

func get_sprite_width()->float:
	return 0
