extends Node2D
class_name MovingItemManager

var items:Array[MovingItem] = []
var item_distance:float
var moving_speed:float

func _ready():
	init()
	
	for item in get_children():
		if item is MovingItem:
			item.set_speed(moving_speed)
			items.push_back(item)
	
	item_distance = items[0].get_sprite_width() - 1
	
	arange_item_positions()
	
func init():
	pass
			
func arange_item_positions():
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
