extends Control

@onready var blackrect_fade = $CanvasLayer/ColorRect
@onready var startmenu_sfx_start = $sfx_start
@onready var parent_node = get_parent()
var heartbeat_background
var fade_duration = 3.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	heartbeat_background = parent_node.get_node("audio_background")
	blackrect_fade.modulate.a = 1
	#blackrect_fade.show() # bug: blocking mouse action of dialogue
	var fadein_tween = get_tree().create_tween()
	#fadein_tween.set_parallel(true)
	#Global.saved_current_music_lvl = db_to_linear(AudioServer.get_bus_volume_db(1))
	#fadeout_tween.tween_property(current_music, "volume_db", -80.0, fade_duration)
	#current_music._fademusic_lvl1()
	fadein_tween.tween_property(blackrect_fade, "modulate:a", 0, fade_duration)
	await fadein_tween.finished

func start_transition():
	blackrect_fade.show()
	heartbeat_background.stop()
	startmenu_sfx_start.play()
	var fadeout_tween = get_tree().create_tween()
	fadeout_tween.set_parallel(true)
	#Global.saved_current_music_lvl = db_to_linear(AudioServer.get_bus_volume_db(1))
	#fadeout_tween.tween_property(current_music, "volume_db", -80.0, fade_duration)
	#current_music._fademusic_lvl1()
	fadeout_tween.tween_property(blackrect_fade, "modulate:a", 1, fade_duration)
	await fadeout_tween.finished
	get_tree().change_scene_to_file("res://scenes/mapfinal_2.tscn")
	#get_tree().change_scene_to_file("res://scenes/openinglogoscene/opening_logo_scene.tscn")
