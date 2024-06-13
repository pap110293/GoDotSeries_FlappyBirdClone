extends MovingItem
class_name Background

@onready var sprite = $Sprite2D

func get_sprite_width()->float:
	return sprite.texture.get_size().x
