extends Control

#@onready var thisnode_canvaslayer = $CanvasLayer
@onready var thisnodes_container = $CanvasLayer/Container
#@onready var backdrop : TextureRect = $CanvasLayer/Container/Backdrop
@onready var signpost : TextureRect = $CanvasLayer/Container/lvl1_left
@onready var house : TextureRect = $CanvasLayer/Container/lvl1_mid
@onready var necklace : TextureRect = $CanvasLayer/Container/lvl1_right
@onready var wholelvl1 : TextureRect = $CanvasLayer/Container/lvl1_left_post

@onready var stall : TextureRect = $CanvasLayer/Container/lvl2_left
@onready var boat : TextureRect = $CanvasLayer/Container/lvl2_mid
@onready var tallhouse : TextureRect = $CanvasLayer/Container/lvl2_right
@onready var wholelvl2 : TextureRect = $CanvasLayer/Container/lvl2_left_post

@onready var bucket : TextureRect = $CanvasLayer/Container/lvl3_left
@onready var statue : TextureRect = $CanvasLayer/Container/lvl3_mid
@onready var door : TextureRect = $CanvasLayer/Container/lvl3_right
@onready var wholelvl3 : TextureRect = $CanvasLayer/Container/lvl3_left_post

@onready var lvlfinal1 : TextureRect = $CanvasLayer/Container/lvlfinal1
@onready var lvlfinal2 : TextureRect = $CanvasLayer/Container/lvlfinal2

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
	if this_cutscene in ["signpost", "necklace", "house", "wholelvl1"]:
		cutscene_level = "lvl1"
	elif this_cutscene in ["tallhouse", "stall", "boat", "wholelvl2"]:
		cutscene_level = "lvl2"
	elif this_cutscene in ["bucket", "statue", "door", "wholelvl3"]:
		cutscene_level = "lvl3"
	elif this_cutscene in ["lvlfinal1"]:
		cutscene_level = "lvlfinal1"
	elif this_cutscene in ["lvlfinal2"]:
		cutscene_level = "lvlfinal2"
	if cutscene_level == "lvl1":
		signpost.modulate.a = 1
		house.modulate.a = 1
		necklace.modulate.a = 1
		wholelvl1.modulate.a = 0
		if "signpost" in cutscenes_called:
			#signpost.show()
			if this_cutscene == "signpost":
				signpost.show()
				while cutscene_running:
					tween1 = create_tween()
					tween1.tween_property(signpost, "modulate:a", 0, cutscene_slice_fade_duration)
					await tween1.finished
					tween1 = create_tween()
					tween1.tween_property(signpost, "modulate:a", 1, cutscene_slice_fade_duration)
					await tween1.finished
				tween1 = create_tween()
				tween1.tween_property(signpost, "modulate:a", 0, cutscene_slice_fade_duration)
				signpost.hide()
		if "necklace" in cutscenes_called:
			#necklace.show()
			if this_cutscene == "necklace":
				necklace.show()
				while cutscene_running:
					tween1 = create_tween()
					tween1.tween_property(necklace, "modulate:a", 0, cutscene_slice_fade_duration)
					await tween1.finished
					tween1 = create_tween()
					tween1.tween_property(necklace, "modulate:a", 1, cutscene_slice_fade_duration)
					await tween1.finished
				tween1 = create_tween()
				tween1.tween_property(necklace, "modulate:a", 0, cutscene_slice_fade_duration)
				necklace.hide()
		if "house" in cutscenes_called:
			#house.show()
			if this_cutscene == "house":
				house.show()
				while cutscene_running:
					tween1 = create_tween()
					tween1.tween_property(house, "modulate:a", 0, cutscene_slice_fade_duration)
					await tween1.finished
					tween1 = create_tween()
					tween1.tween_property(house, "modulate:a", 1, cutscene_slice_fade_duration)
					await tween1.finished
				tween1 = create_tween()
				tween1.tween_property(house, "modulate:a", 0, cutscene_slice_fade_duration)
				house.hide()
		if "wholelvl1" in cutscenes_called:
			#wholelvl1.show()
			if this_cutscene == "wholelvl1":
				wholelvl1.show()
				while cutscene_running:
					tween1 = create_tween()
					tween1.tween_property(wholelvl1, "modulate:a", 0, cutscene_slice_fade_duration)
					await tween1.finished
					tween1 = create_tween()
					tween1.tween_property(wholelvl1, "modulate:a", 1, cutscene_slice_fade_duration)
					await tween1.finished
				wholelvl1.hide()
	if cutscene_level == "lvl2":
		tallhouse.modulate.a = 1
		stall.modulate.a = 1
		boat.modulate.a = 1
		wholelvl2.modulate.a = 0
		if "tallhouse" in cutscenes_called:
			#tallhouse.show()
			if this_cutscene == "tallhouse":
				tallhouse.show()
				while cutscene_running:
					tween1 = create_tween()
					tween1.tween_property(tallhouse, "modulate:a", 0, cutscene_slice_fade_duration)
					await tween1.finished
					tween1 = create_tween()
					tween1.tween_property(tallhouse, "modulate:a", 1, cutscene_slice_fade_duration)
					await tween1.finished
				tween1 = create_tween()
				tween1.tween_property(tallhouse, "modulate:a", 0, cutscene_slice_fade_duration)
				tallhouse.hide()
		if "stall" in cutscenes_called:
			#stall.show()
			if this_cutscene == "stall":
				stall.show()
				while cutscene_running:
					tween1 = create_tween()
					tween1.tween_property(stall, "modulate:a", 0, cutscene_slice_fade_duration)
					await tween1.finished
					tween1 = create_tween()
					tween1.tween_property(stall, "modulate:a", 1, cutscene_slice_fade_duration)
					await tween1.finished
				tween1 = create_tween()
				tween1.tween_property(stall, "modulate:a", 0, cutscene_slice_fade_duration)
				stall.hide()
		if "boat" in cutscenes_called:
			#boat.show()
			if this_cutscene == "boat":
				boat.show()
				while cutscene_running:
					tween1 = create_tween()
					tween1.tween_property(boat, "modulate:a", 0, cutscene_slice_fade_duration)
					await tween1.finished
					tween1 = create_tween()
					tween1.tween_property(boat, "modulate:a", 1, cutscene_slice_fade_duration)
					await tween1.finished
				tween1 = create_tween()
				tween1.tween_property(boat, "modulate:a", 0, cutscene_slice_fade_duration)
				boat.hide()
		if "wholelvl2" in cutscenes_called:
			#wholelvl2.show()
			if this_cutscene == "wholelvl2":
				wholelvl2.show()
				while cutscene_running:
					tween1 = create_tween()
					tween1.tween_property(wholelvl2, "modulate:a", 0, cutscene_slice_fade_duration)
					await tween1.finished
					tween1 = create_tween()
					tween1.tween_property(wholelvl2, "modulate:a", 1, cutscene_slice_fade_duration)
					await tween1.finished
				wholelvl2.hide()
	if cutscene_level == "lvl3":
		bucket.modulate.a = 1
		statue.modulate.a = 1
		door.modulate.a = 1
		wholelvl3.modulate.a = 0
		if "bucket" in cutscenes_called:
			#bucket.show()
			if this_cutscene == "bucket":
				bucket.show()
				while cutscene_running:
					tween1 = create_tween()
					tween1.tween_property(bucket, "modulate:a", 0, cutscene_slice_fade_duration)
					await tween1.finished
					tween1 = create_tween()
					tween1.tween_property(bucket, "modulate:a", 1, cutscene_slice_fade_duration)
					await tween1.finished
				tween1 = create_tween()
				tween1.tween_property(bucket, "modulate:a", 0, cutscene_slice_fade_duration)
				bucket.hide()
		if "statue" in cutscenes_called:
			#statue.show()
			if this_cutscene == "statue":
				statue.show()
				while cutscene_running:
					tween1 = create_tween()
					tween1.tween_property(statue, "modulate:a", 0, cutscene_slice_fade_duration)
					await tween1.finished
					tween1 = create_tween()
					tween1.tween_property(statue, "modulate:a", 1, cutscene_slice_fade_duration)
					await tween1.finished
				tween1 = create_tween()
				tween1.tween_property(statue, "modulate:a", 0, cutscene_slice_fade_duration)
				statue.hide()
		if "door" in cutscenes_called:
			#door.show()
			if this_cutscene == "door":
				door.show()
				while cutscene_running:
					tween1 = create_tween()
					tween1.tween_property(door, "modulate:a", 0, cutscene_slice_fade_duration)
					await tween1.finished
					tween1 = create_tween()
					tween1.tween_property(door, "modulate:a", 1, cutscene_slice_fade_duration)
					await tween1.finished
				tween1 = create_tween()
				tween1.tween_property(door, "modulate:a", 0, cutscene_slice_fade_duration)
				door.hide()
		if "wholelvl3" in cutscenes_called:
			#wholelvl3.show()
			if this_cutscene == "wholelvl3":
				wholelvl3.show()
				while cutscene_running:
					tween1 = create_tween()
					tween1.tween_property(wholelvl3, "modulate:a", 0, cutscene_slice_fade_duration)
					await tween1.finished
					tween1 = create_tween()
					tween1.tween_property(wholelvl3, "modulate:a", 1, cutscene_slice_fade_duration)
					await tween1.finished
				wholelvl3.hide()
	if cutscene_level == "lvlfinal1":
		lvlfinal1.modulate.a = 0
		if "lvlfinal1" in cutscenes_called:
			#lvlfinal1.show()
			if this_cutscene == "lvlfinal1":
				lvlfinal1.show()
				tween1 = create_tween()
				tween1.tween_property(lvlfinal1, "modulate:a", 1, cutscene_slice_fade_duration)
				await tween1.finished
	if cutscene_level == "lvlfinal2":
		lvlfinal2.modulate.a = 0
		if "lvlfinal2" in cutscenes_called:
			#lvlfinal2.show()
			if this_cutscene == "lvlfinal2":
				lvlfinal2.show()
				tween1 = create_tween()
				tween1.tween_property(lvlfinal2, "modulate:a", 1, cutscene_slice_fade_duration)
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
