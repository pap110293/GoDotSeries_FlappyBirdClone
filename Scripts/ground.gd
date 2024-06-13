extends MovingItem
class_name Ground

@onready var sprite = $Sprite2D

func get_sprite_width()->float:
	return sprite.texture.get_size().x
