extends Area2D

@export var score_to_add:int = 1

func _on_body_entered(body):
	if body.has_method("add_score"):
		body.add_score(score_to_add)
		queue_free()
