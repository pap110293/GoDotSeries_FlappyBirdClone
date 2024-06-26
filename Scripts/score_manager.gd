extends Node

signal score_updated

@export var score_label:Label

var score:int

func _ready():
	%GameManager.game_over.connect(_on_game_over)
	%GameManager.game_start.connect(_on_game_start)
	score_updated.connect(_on_score_updated)
	load_score()
	score_label.visible = false

func load_score():
	# TODO: load score from save
	score = 0
	score_updated.emit()

func save_score()->void:
	# TODO: save the score
	pass

func add_score(added_score:int):
	score += added_score
	score_updated.emit()
	
func _on_game_over():
	save_score()
	
func _on_game_start()->void:
	score_label.visible = true
	
func _on_score_updated()->void:
	score_label.text = str(score)
