extends Node2D

var tracks = []
var mute = -80
var full = 8

func _ready():
	# Get all 7 AudioStreamPlayer children
	for i in range(7):
		var track = get_child(i)
		if track is AudioStreamPlayer2D:
			tracks.append(track)
			print(track)
		else:
			print("not track")
	# Ensure we have exactly 7 tracks
	if tracks.size() != 7:
		push_error("MusicManager requires exactly 7 AudioStreamPlayer2D nodes as children!")
		return
	# Initialize track volumes
	initialize_music_layers()
	# Play all tracks
	for track in tracks:
		track.play()
	# Initialize starting track set
	initialize_starting_track_set()


func set_music_layer(index: int, volume_db: float):
	if index >= 0 and index < tracks.size():
		tracks[index].volume_db = volume_db
	else:
		push_error("Invalid track index: " + str(index))

func initialize_music_layers():
	set_music_scene_0()
	print("set_music_scene_0()")

func initialize_starting_track_set():
	set_music_scene_1()
	print("set_music_scene_1()")

func set_music_scene_0():
	set_music_layer(0, mute) # Muted
	set_music_layer(1, mute)
	set_music_layer(2, mute)
	set_music_layer(3, mute) 
	set_music_layer(4, mute) 
	set_music_layer(5, mute)
	set_music_layer(6, mute)

func set_music_scene_1():
	set_music_layer(0, -6) # Full
	set_music_layer(1, mute)
	set_music_layer(2, mute)
	set_music_layer(3, mute) 
	set_music_layer(4, mute) 
	set_music_layer(5, mute)
	set_music_layer(6, mute)
