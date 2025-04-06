extends Control

@onready var blackrect_fade = $CanvasLayer/ColorRect
@onready var current_music = $/root/Map_Danic/Player_Char2D/MusicManager
var fade_duration = 3.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	blackrect_fade.modulate.a = 0

func start_transition():
	blackrect_fade.show()
	SfxUI.play_sfx_completion()
	var fadeout_tween = get_tree().create_tween()
	fadeout_tween.set_parallel(true)
	current_music._fademusic_lvl1()
	fadeout_tween.tween_property(blackrect_fade, "modulate:a", 1, fade_duration)
	await fadeout_tween.finished
	get_tree().change_scene_to_file("res://scenes/map_2.tscn")
