extends Node2D

@onready var _puzzle_popup = $Player_Char2D/Puzzle

func _input(event):
	#print(event.name)
	if event is InputEventKey and event.is_pressed() and event.get_keycode() == KEY_P:
		_puzzle_popup.visible = not _puzzle_popup.visible
