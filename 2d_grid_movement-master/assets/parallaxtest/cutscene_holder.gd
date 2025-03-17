extends Control

#@onready var thisnode_canvaslayer = $CanvasLayer
@onready var thisnodes_container = $CanvasLayer/Container
@onready var back : TextureRect = $CanvasLayer/Container/TextureRect
@onready var back2 : TextureRect = $CanvasLayer/Container/TextureRect2
@onready var back3 : TextureRect = $CanvasLayer/Container/TextureRect3
@onready var back4 : TextureRect = $CanvasLayer/Container/TextureRect4
@onready var timer : Timer = $CanvasLayer/Timer_par

var fade_duration = 2
var cutscene_running = false

var timer_time = 5
var move_amount = 50
var moving_forward = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	thisnodes_container.modulate.a = 0 #test
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func start_cutscene():
	if cutscene_running:
		return
	cutscene_running = true
	thisnodes_container.modulate.a = 0
	#thisnode_canvaslayer.show()
	#fade_in()
	var tween = create_tween()
	tween.tween_property(thisnodes_container, "modulate:a", 1.0, fade_duration)
	var tween1 = create_tween()
	var tween2 = create_tween()
	var tween3 = create_tween()
	if moving_forward:
		tween1.tween_property(back4, "position:x", back4.position.x - move_amount, timer_time)
		tween2.tween_property(back3, "position:x", back3.position.x + move_amount, timer_time)
		tween3.tween_property(back2, "position:y", back4.position.y - move_amount, timer_time)
	else:
		tween1.tween_property(back4, "position:x", back4.position.x + move_amount, timer_time)
		tween2.tween_property(back3, "position:x", back3.position.x - move_amount, timer_time)
		tween3.tween_property(back2, "position:y", back2.position.y + move_amount, timer_time)
	timer.wait_time = timer_time
	timer.start()


func _on_timer_timeout() -> void:
	if not cutscene_running:
		return
	var tween1 = create_tween()
	var tween2 = create_tween()
	var tween3 = create_tween()
	if moving_forward:
		tween1.tween_property(back4, "position:x", back4.position.x - move_amount, timer_time)
		tween2.tween_property(back3, "position:x", back3.position.x + move_amount, timer_time)
		tween3.tween_property(back2, "position:y", back4.position.y - move_amount, timer_time)
	else:
		tween1.tween_property(back4, "position:x", back4.position.x + move_amount, timer_time)
		tween2.tween_property(back3, "position:x", back3.position.x - move_amount, timer_time)
		tween3.tween_property(back2, "position:y", back2.position.y + move_amount, timer_time)
	moving_forward = !moving_forward
	#timer.wait_time = timer_time
	timer.start()  # Restart timer for the next loop

func stop_cutscene():
	cutscene_running = false
	#fade_out()
	var tween5 = create_tween()
	tween5.tween_property(thisnodes_container, "modulate:a", 0.0, fade_duration)
	tween5.finished.connect(_on_fade_out_complete)  # Call function when tween ends
	timer.stop()

#func fade_in():
	#create_tween().tween_property(self, "modulate:a", 1.0, fade_duration)
#
#func fade_out():
	#create_tween().tween_property(self, "modulate:a", 0.0, fade_duration)

func _on_fade_out_complete() -> void:
	pass
	#thisnode_canvaslayer.hide()
	#thisnodes_container.modulate.a = 1 #test
