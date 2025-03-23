extends Control

#@onready var thisnode_canvaslayer = $CanvasLayer
@onready var thisnodes_container = $CanvasLayer/Container
#@onready var backdrop : TextureRect = $CanvasLayer/Container/Backdrop
@onready var signpost : TextureRect = $CanvasLayer/Container/lvl1_left
@onready var house : TextureRect = $CanvasLayer/Container/lvl1_mid
@onready var necklace : TextureRect = $CanvasLayer/Container/lvl1_right

@onready var marketstall : TextureRect = $CanvasLayer/Container/lvl2_left
@onready var boat : TextureRect = $CanvasLayer/Container/lvl2_mid
@onready var manor : TextureRect = $CanvasLayer/Container/lvl2_right
@onready var marketstall_post : TextureRect = $CanvasLayer/Container/lvl2_left_post

@onready var timer : Timer = $CanvasLayer/Timer_par
var cutscenes_called = []
var cutscene_level = ""
var this_cutscene = ""
var cutscene_slice_fade_duration = 2.0

var fade_duration = 2
var cutscene_running = false

var timer_time = 5
var move_amount = 50
var moving_forward = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	thisnodes_container.modulate.a = 0 #test
	#thisnodes_container.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_cutscene(cutscene_name: String):
	if cutscene_running:
		return
	cutscene_running = true
	this_cutscene = cutscene_name
	cutscenes_called.append(cutscene_name)
	thisnodes_container.modulate.a = 0
	#thisnode_canvaslayer.show()
	var tween = create_tween()
	tween.tween_property(thisnodes_container, "modulate:a", 1.0, fade_duration)
	var tween1 = create_tween()
	if this_cutscene in ["signpost", "necklace", "house"]:
		cutscene_level = "lvl1"
	elif this_cutscene in ["marketstall", "boat", "manor", "marketstall_post"]:
		cutscene_level = "lvl2"
	if cutscene_level == "lvl1":
		signpost.modulate.a = 1
		house.modulate.a = 1
		necklace.modulate.a = 1
		if "signpost" in cutscenes_called:
			signpost.show()
			if this_cutscene == "signpost":
				while cutscene_running:
					tween1 = create_tween()
					tween1.tween_property(signpost, "modulate:a", 0, cutscene_slice_fade_duration)
					await tween1.finished
					tween1 = create_tween()
					tween1.tween_property(signpost, "modulate:a", 1, cutscene_slice_fade_duration)
					await tween1.finished
		if "necklace" in cutscenes_called:
			necklace.show()
			if this_cutscene == "necklace":
				while cutscene_running:
					tween1 = create_tween()
					tween1.tween_property(necklace, "modulate:a", 0, cutscene_slice_fade_duration)
					await tween1.finished
					tween1 = create_tween()
					tween1.tween_property(necklace, "modulate:a", 1, cutscene_slice_fade_duration)
					await tween1.finished
		if "house" in cutscenes_called:
			house.show()
			if this_cutscene == "house":
				while cutscene_running:
					tween1 = create_tween()
					tween1.tween_property(house, "modulate:a", 0, cutscene_slice_fade_duration)
					await tween1.finished
					tween1 = create_tween()
					tween1.tween_property(house, "modulate:a", 1, cutscene_slice_fade_duration)
					await tween1.finished

	#var tween2 = create_tween()
	#var tween3 = create_tween()
	#if moving_forward:
		#tween1.tween_property(back4, "position:x", back4.position.x - move_amount, timer_time)
		#tween2.tween_property(back3, "position:x", back3.position.x + move_amount, timer_time)
		#tween3.tween_property(back2, "position:y", back4.position.y - move_amount, timer_time)
	#else:
		#tween1.tween_property(back4, "position:x", back4.position.x + move_amount, timer_time)
		#tween2.tween_property(back3, "position:x", back3.position.x - move_amount, timer_time)
		#tween3.tween_property(back2, "position:y", back2.position.y + move_amount, timer_time)
	#timer.wait_time = timer_time
	#timer.start()


func _on_timer_timeout() -> void:
	if not cutscene_running:
		return
	#var tween1 = create_tween()
	#var tween2 = create_tween()
	#var tween3 = create_tween()
	#if moving_forward:
		#tween1.tween_property(back4, "position:x", back4.position.x - move_amount, timer_time)
		#tween2.tween_property(back3, "position:x", back3.position.x + move_amount, timer_time)
		#tween3.tween_property(back2, "position:y", back4.position.y - move_amount, timer_time)
	#else:
		#tween1.tween_property(back4, "position:x", back4.position.x + move_amount, timer_time)
		#tween2.tween_property(back3, "position:x", back3.position.x - move_amount, timer_time)
		#tween3.tween_property(back2, "position:y", back2.position.y + move_amount, timer_time)
	#moving_forward = !moving_forward
	##timer.wait_time = timer_time
	#timer.start()  # Restart timer for the next loop

func stop_cutscene():
	cutscene_running = false
	var tween5 = create_tween()
	tween5.tween_property(thisnodes_container, "modulate:a", 0.0, fade_duration)
	tween5.finished.connect(_on_fade_out_complete)  # Call function when tween ends
	timer.stop()

func _on_fade_out_complete() -> void:
	pass
	#thisnodes_container.hide()
	#thisnodes_container.modulate.a = 1 #test
