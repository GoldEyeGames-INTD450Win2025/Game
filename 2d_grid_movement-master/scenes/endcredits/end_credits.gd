extends Control

@onready var thisnodes_container = $CanvasLayer/Panel
@onready var background : ColorRect = $CanvasLayer/Panel/ColorRect
@onready var credits : RichTextLabel = $CanvasLayer/Panel/Control/RichTextLabel
var scene_startmenu_location = "res://scenes/startmenu/start_menu.tscn"

var fade_duration = 3
var credits_running = false
var scroll_speed = 40.0  # Pixels per delta
var credits_end_y_position = -3578.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if credits_running:
		credits.position.y -= scroll_speed * delta  # Move upward slowly
		if credits.position.y < credits_end_y_position:
			stop_cutscene()

func start_creditroll():
	if credits_running:
		return
	credits_running = true
	thisnodes_container.modulate.a = 0
	thisnodes_container.show()
	var tween = create_tween()
	tween.tween_property(thisnodes_container, "modulate:a", 1.0, fade_duration)

func stop_cutscene():
	credits_running = false
	var tween5 = create_tween()
	tween5.tween_property(thisnodes_container, "modulate:a", 0.0, fade_duration)
	# return to title screen
	await tween5.finished
	thisnodes_container.hide()
	get_tree().change_scene_to_file(scene_startmenu_location)
