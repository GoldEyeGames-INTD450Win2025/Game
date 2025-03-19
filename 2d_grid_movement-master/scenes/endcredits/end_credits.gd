extends Control

@onready var thisnodes_container = $CanvasLayer/Panel
@onready var background : ColorRect = $CanvasLayer/Panel/ColorRect
@onready var credits : RichTextLabel = $CanvasLayer/Panel/Control/RichTextLabel

var fade_duration = 2
var credits_running = false
var scroll_speed = 40.0  # Pixels per delta

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#start_creditroll()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if credits_running:
		credits.position.y -= scroll_speed * delta  # Move upward slowly

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
