extends Area2D

func _process(delta:float):
	pass

func _on_body_entered(body: Node2D) -> void:
	print(body.name)
	if body.is_in_group("Player"):
		var pos = body.global_position
		body.global_position = -pos + 100 * (pos / abs(pos))
