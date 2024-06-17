extends MovingItemManager

@export var spawPos:Vector2
@export var speed:float = 100

func _ready():
	moving_speed = speed
	should_arrange_item = false
	%GameManager.game_over.connect(stop_all)
	super._ready()
