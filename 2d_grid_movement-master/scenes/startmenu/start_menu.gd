extends Control

@onready var blackrect_fade = $ColorRect
@onready var startmenu_music = $music
@onready var startmenu_sfx_nonstart = $sfx_nonstart
@onready var startmenu_sfx_nonstart2 = $sfx_nonstart2
@onready var startmenu_sfx_start = $sfx_start
var fade_duration = 3.0
@onready var optionsmenu = $Starts_PauseMenu
@onready var notemenu = $Starts_NoteMenu
@onready var lvlmenu = $Starts_LvlSelect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	blackrect_fade.modulate.a = 1
	blackrect_fade.show()
	startmenu_music.play()
	start_animation()

func start_animation():
	var fade_tween = get_tree().create_tween()
	fade_tween.tween_property(blackrect_fade, "modulate:a", 0, fade_duration)
	await fade_tween.finished

func _on_button_start_pressed():
	startmenu_sfx_start.play()
	var fadeout_tween = get_tree().create_tween()
	fadeout_tween.set_parallel(true)
	fadeout_tween.tween_property(startmenu_music, "volume_db", -80.0, fade_duration)
	fadeout_tween.tween_property(blackrect_fade, "modulate:a", 1, fade_duration)
	await fadeout_tween.finished
	get_tree().change_scene_to_file("res://scenes/map_danic.tscn")


func _on_button_options_pressed():
	startmenu_sfx_nonstart.play()
	optionsmenu.show()

func hide_options_menu():
	startmenu_sfx_nonstart2.play()
	optionsmenu.hide()


func _on_button_quit_pressed():
	startmenu_sfx_nonstart.play()
	var fadeoutquit_tween = get_tree().create_tween()
	fadeoutquit_tween.set_parallel(true)
	fadeoutquit_tween.tween_property(startmenu_music, "volume_db", -80.0, fade_duration)
	fadeoutquit_tween.tween_property(blackrect_fade, "modulate:a", 1, fade_duration)
	await fadeoutquit_tween.finished
	get_tree().quit()


func _on_button_note_pressed() -> void:
	startmenu_sfx_nonstart.play()
	notemenu.show()

func hide_note_menu():
	startmenu_sfx_nonstart2.play()
	notemenu.hide()


func _on_button_lvl_pressed() -> void:
	startmenu_sfx_nonstart.play()
	lvlmenu.show()

func hide_lvl_menu():
	startmenu_sfx_nonstart2.play()
	lvlmenu.hide()
