extends Node2D

signal puzzle_reset_signal_emitted

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Global.puzzle_reset_triggering_dialogue == true:
		puzzle_reset_signal_emitted.emit()
		Global.puzzle_reset_triggering_dialogue = false
