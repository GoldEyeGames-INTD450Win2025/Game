extends Control

@onready var startmenu = get_parent()

func _on_button_resume_note_pressed() -> void:
	startmenu.hide_note_menu()
