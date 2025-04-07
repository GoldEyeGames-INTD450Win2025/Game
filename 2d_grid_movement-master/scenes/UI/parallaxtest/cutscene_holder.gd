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

func handle_partial_cutscene(stringname : String, propertyname):
	if stringname in cutscenes_called:
		if this_cutscene == stringname:
			propertyname.show()
			for i in range(2):
				var tween1 = create_tween()
				tween1.tween_property(propertyname, "modulate:a", 0, cutscene_slice_fade_duration)
				await tween1.finished
				var tween2 = create_tween()
				tween2.tween_property(propertyname, "modulate:a", 1, cutscene_slice_fade_duration)
				await tween2.finished
			while cutscene_running:
				await get_tree().process_frame
			var tween3 = create_tween()
			tween3.tween_property(propertyname, "modulate:a", 0, cutscene_slice_fade_duration)
			await tween3.finished
			propertyname.hide()

func handle_full_cutscene(stringname : String, propertyname):
	if stringname in cutscenes_called:
		if this_cutscene == stringname:
			propertyname.show()
			for i in range(2):
				var tween1 = create_tween()
				tween1.tween_property(propertyname, "modulate:a", 0, cutscene_slice_fade_duration)
				await tween1.finished
				var tween2 = create_tween()
				tween2.tween_property(propertyname, "modulate:a", 1, cutscene_slice_fade_duration)
				await tween2.finished
			while cutscene_running:
				await get_tree().process_frame
			var tween3 = create_tween()
			tween3.tween_property(propertyname, "modulate:a", 0, cutscene_slice_fade_duration)
			await tween3.finished
			propertyname.hide()

func start_cutscene(cutscene_name: String):
	if cutscene_running:
		return
	cutscene_running = true
	this_cutscene = cutscene_name
	cutscenes_called.append(cutscene_name)
	thisnodes_container.modulate.a = 0
	var tween4 = create_tween()
	tween4.tween_property(thisnodes_container, "modulate:a", 1.0, fade_duration)
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
		handle_partial_cutscene("signpost", signpost)
		handle_partial_cutscene("necklace", necklace)
		handle_partial_cutscene("house", house)
		handle_full_cutscene("wholelvl1", wholelvl1)
	if cutscene_level == "lvl2":
		tallhouse.modulate.a = 1
		stall.modulate.a = 1
		boat.modulate.a = 1
		wholelvl2.modulate.a = 0
		handle_partial_cutscene("tallhouse", tallhouse)
		handle_partial_cutscene("stall", stall)
		handle_partial_cutscene("boat", boat)
		handle_full_cutscene("wholelvl2", wholelvl2)
	if cutscene_level == "lvl3":
		bucket.modulate.a = 1
		statue.modulate.a = 1
		door.modulate.a = 1
		wholelvl3.modulate.a = 0
		handle_partial_cutscene("bucket", bucket)
		handle_partial_cutscene("statue", statue)
		handle_partial_cutscene("door", door)
		handle_full_cutscene("wholelvl3", wholelvl3)
	if cutscene_level == "lvlfinal1":
		lvlfinal1.modulate.a = 0
		if "lvlfinal1" in cutscenes_called:
			#lvlfinal1.show()
			if this_cutscene == "lvlfinal1":
				lvlfinal1.show()
				var tween5 = create_tween()
				tween5.tween_property(lvlfinal1, "modulate:a", 1, cutscene_slice_fade_duration)
				await tween5.finished
	if cutscene_level == "lvlfinal2":
		lvlfinal2.modulate.a = 0
		if "lvlfinal2" in cutscenes_called:
			#lvlfinal2.show()
			if this_cutscene == "lvlfinal2":
				lvlfinal2.show()
				var tween6 = create_tween()
				tween6.tween_property(lvlfinal2, "modulate:a", 1, cutscene_slice_fade_duration)
				await tween6.finished


func _on_timer_timeout() -> void:
	if not cutscene_running:
		return

func stop_cutscene():
	cutscene_running = false
	var tween7 = create_tween()
	tween7.tween_property(thisnodes_container, "modulate:a", 0.0, fade_duration)
	tween7.finished.connect(_on_fade_out_complete)  # Call function when tween ends
	#timer.stop()

func _on_fade_out_complete() -> void:
	pass
	#thisnodes_container.hide()
	#thisnodes_container.modulate.a = 1 #test
