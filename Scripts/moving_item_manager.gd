extends Node2D

class_name MovingItemManager

var items:Array[MovingItem] = []
var item_distance:float
var moving_speed:float
var should_arrange_item:bool = true

func _ready():
	%GameManager.game_over.connect(stop_all)
	%GameManager.game_start.connect(_on_game_start)
	
	for item in get_children():
		if item is MovingItem:
			item.set_speed(moving_speed)
			items.append(item)
	
	if !items.is_empty():
		item_distance = items[0].get_sprite_width() - 1
	
	arange_item_positions()
	
func arange_item_positions():
	if should_arrange_item:
		var itemPositionX = global_position.x
		for item in items:
			item.global_position.x = itemPositionX
			itemPositionX += item_distance

func find_last_item():
	var last_item
	var x_position = -999
	for item in items:
		if item.global_position.x > x_position:
			x_position = item.global_position.x
			last_item = item
	
	return last_item
	
func move_to_the_last(body):
	var last_round = find_last_item()
	body.global_position.x = last_round.global_position.x + item_distance

func stop_all():
	for item in items:
		item.stop_moving()
		
func start_all():
	for item in items:
		item.start_moving()

func _on_game_start():
	start_all()
