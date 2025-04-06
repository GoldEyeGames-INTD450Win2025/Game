extends Control

@onready var startmenu = get_parent()

func _on_button_resume_pressed():
	startmenu.hide_lvl_menu()

func _on_button_lvl_0_pressed() -> void:
	SfxUI.play_sfx_Start()
	get_tree().change_scene_to_file("res://scenes/openinglogoscene/opening_logo_scene.tscn")

func _on_button_lvl_1_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/map_danic.tscn")

func _on_button_lvl_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/map_2.tscn")

func _on_button_lvl_3_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/map3_coastisland.tscn")

func _on_button_lvlfinal_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/mapfinal_1.tscn")
