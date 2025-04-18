extends Control

@onready var pause_menu_visibility = $CanvasLayer/Panel
var is_paused = false
@onready var slider_sfx = $CanvasLayer/Panel/MarginContainer/VBoxContainer/HSlider_SFX
@onready var slider_music = $CanvasLayer/Panel/MarginContainer/VBoxContainer/HSlider_Music
@onready var sfxtester = $SFXtester
@onready var sfxtester2 = $SFXtester2
#var scene_quittomain = "res://scenes/startmenu/start_menu.tscn"

## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	slider_sfx.value = db_to_linear(AudioServer.get_bus_volume_db(2))
	slider_music.value = db_to_linear(AudioServer.get_bus_volume_db(1))
	is_paused = false
	#if pause_menu_visibility:
	pause_menu_visibility.hide()

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		toggle_pause()
	#if is_paused and Input.is_action_just_pressed("next"):
		#toggle_pause()

func toggle_pause():
	is_paused = !is_paused
	print("is_paused = " + str(is_paused))
	if is_paused:
		sfxtester.play()
		#SfxUi.play_sfx_open_close()
	else:
		sfxtester2.play()
	#get_tree().paused = is_paused  # Freeze game logic
	# * Stop Player Movement: Ensure that your player node's process_mode is set to PROCESS_MODE_PAUSABLE.
	Engine.time_scale = !is_paused # Freeze game logic
	pause_menu_visibility.visible = is_paused  # Show or hide menu
	Global.pause_menu_open = is_paused

func _on_h_slider_sfx_drag_ended(_value_changed: bool) -> void:
	AudioServer.set_bus_volume_db(2, linear_to_db(slider_sfx.value))
	# play SFX sound to test 
	#sfxtester.play()
	SfxUi.play_sfx_open_close()

func _on_h_slider_music_drag_ended(_value_changed: bool) -> void:
	AudioServer.set_bus_volume_db(1, linear_to_db(slider_music.value))

func _on_button_resume_pressed():
	toggle_pause()

func _on_button_quit_pressed():
	toggle_pause()
	Global.puzzle_open = false
	get_tree().change_scene_to_file("res://scenes/startmenu/start_menu.tscn")
