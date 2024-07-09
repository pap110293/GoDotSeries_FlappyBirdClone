extends Node

signal score_updated

@export var score_label:Label
const POINT = preload("res://Assets/Audio/point.ogg")

@onready var audio_manager = $AudioManager
const POINT_SOUND_NAME = "POINT"
const SAVE_PATH = "user://score.save"

var score:int = 0

func _ready():
	%GameManager.game_over.connect(_on_game_over)
	%GameManager.game_start.connect(_on_game_start)
	score_updated.connect(_on_score_updated)
	score_label.visible = false
	audio_manager.add_stream(POINT_SOUND_NAME, POINT)

func save_score()->void:
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		var hightest_score = file.get_var()
		if hightest_score < score:
			file.store_var(score)
	else:
		var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
		file.store_var(score)

func add_score(added_score:int):
	score += added_score
	score_updated.emit()
	
func update_score_lable()->void:
	score_label.text = str(score)
	
func _on_game_over():
	save_score()
	
func _on_game_start()->void:
	score_label.visible = true
	update_score_lable()
	
func _on_score_updated()->void:
	audio_manager.play_stream(POINT_SOUND_NAME)
	update_score_lable()
