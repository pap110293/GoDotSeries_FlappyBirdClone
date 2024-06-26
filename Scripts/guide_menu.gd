extends TextureRect

func _ready():
	%GameManager.game_start.connect(_on_game_start)

func _on_game_start()->void:
	visible = false
