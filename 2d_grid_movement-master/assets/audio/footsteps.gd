@tool
extends Node2D

var footsteps : Array[AudioStreamPlayer2D] = []
var current : AudioStreamPlayer2D = null
var orig_pitch = 1.00
var num_of_samples = 4

func _ready():
	for i in range(0, num_of_samples): # from 0 to 5
		var sound = get_node("Audio%d" % i)
		if sound:
			footsteps.append(sound)
	var sample_node = get_node("Audio0")
	orig_pitch = sample_node.pitch_scale

func footsteps_play() -> void:
	if footsteps.size() < num_of_samples:
		return
	var random_index = randi() % footsteps.size()
	current = footsteps[random_index]
	current.pitch_scale = randf_range(orig_pitch - 0.3, orig_pitch + 0.0)
	if not current.playing:  # prevents overlapping sounds
		current.play()
	# Wait for the current sound to finish before playing again
	await get_tree().create_timer(0.3).timeout

func footsteps_stop():
	if current and current.playing: # checks for null
		current.stop()

# editor tester
var playing = false
@export var test_sfx_trigger := false : set = _set_test_sfx_trigger
func _set_test_sfx_trigger(value):
	test_sfx_trigger = value
	if test_sfx_trigger and Engine.is_editor_hint():
		if not playing:
			print("Starting editor footstep loop")
			playing = true
			footstep_loop()
func footstep_loop():
	while test_sfx_trigger and Engine.is_editor_hint():
		# Wait for the footsteps_play to complete before repeating
		await footsteps_play()
	print("Footstep loop stopped")
	playing = false
