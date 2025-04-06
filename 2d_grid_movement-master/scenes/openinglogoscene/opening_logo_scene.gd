extends Control

@onready var logo = $Control
@onready var sound = $AudioStreamPlayer2D
var scene_duration = 5.0
var is_clicked = false
var fade_duration = 2
var scene_startmenu_location = "res://scenes/startmenu/start_menu.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# start logo small and aligned
	logo.scale = Vector2(0.001, 0.001)  
	logo.rotation_degrees = 0
	start_animation()

func start_animation():
	var grow_tween = get_tree().create_tween()
	grow_tween.set_parallel(true)
	grow_tween.tween_property(logo, "scale", Vector2(2, 2), scene_duration).set_trans(Tween.TRANS_EXPO)
	grow_tween.tween_property(logo, "rotation_degrees", 360, scene_duration).set_trans(Tween.TRANS_EXPO)
	await grow_tween.finished
	sound.play()
	is_clicked = true
	finish_scene()

func _input(event):
	# allow click to advance scene faster
	if event is InputEventMouseButton and event.pressed and not is_clicked:
		is_clicked = true
		finish_scene()

func finish_scene():
	var fade_tween = get_tree().create_tween()
	fade_tween.tween_property(logo, "modulate:a", 0, fade_duration)
	await fade_tween.finished
	get_tree().change_scene_to_file(scene_startmenu_location)
