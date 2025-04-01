extends Node2D

var tracks = []
var mute = -80
var full = 0

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
	
	# Find the Activator1 (Area2D) and connect its signal
	var zone_Activator1_Area2D = get_node("../../Activator1_Area2D")  # Adjust path as needed
	if zone_Activator1_Area2D:
		zone_Activator1_Area2D.player_near_Activator1_Area2D.connect(_on_player_nearby_Activator1)
		print("Connected to music signal: Activator1_Area2D")
		
	# Find the Activator2 (Area2D) and connect its signal
	var zone_Activator3_Area2D = get_node("../../Activator3_Area2D")  # Adjust path as needed
	if zone_Activator3_Area2D:
		zone_Activator3_Area2D.player_near_Activator3_Area2D.connect(_on_player_nearby_Activator3)
		print("Connected to music signal: Activator3_Area2D")
		
	# Change music for demo done (puzzle solved)
	var sigd_demoDone = get_node("/root/Map_Danic/Activator3_Area2D/ColorRect2")  # Adjust path as needed
	if sigd_demoDone:
		sigd_demoDone.demo_done_music.connect(_on_demoDone)
		print("Connected to music signal: demo done")

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
	set_music_layer(0, full) # Full
	set_music_layer(1, mute)
	set_music_layer(2, mute)
	set_music_layer(3, mute) 
	set_music_layer(4, mute) 
	set_music_layer(5, mute)
	set_music_layer(6, mute)

func set_music_scene_2():
	set_music_layer(0, mute)
	set_music_layer(1, full)
	set_music_layer(2, mute)
	set_music_layer(3, mute) 
	set_music_layer(4, full*0.5) 
	set_music_layer(5, mute)
	set_music_layer(6, mute)

func set_music_scene_3():
	set_music_layer(0, mute)
	set_music_layer(1, mute)
	set_music_layer(2, full)
	set_music_layer(3, mute) 
	set_music_layer(4, mute)
	set_music_layer(5, full)
	set_music_layer(6, mute)
	
func set_music_scene_4():
	set_music_layer(0, mute)
	set_music_layer(1, full)
	set_music_layer(2, mute)
	set_music_layer(3, mute) 
	set_music_layer(4, full*0.5) 
	set_music_layer(5, full*0.5)
	set_music_layer(6, full*0.5)

func _on_player_nearby_Activator1():
	#set_music_scene_4()
	pass

func _on_player_nearby_Activator3():
	set_music_scene_2()

func _on_demoDone():
	set_music_scene_4()

# * NOTE: fix later
func _fademusic_lvl1():
	set_music_layer(0, mute)
	set_music_layer(1, mute)
	set_music_layer(2, mute)
	set_music_layer(3, mute) 
	set_music_layer(4, mute) 
	set_music_layer(5, mute)
	set_music_layer(6, mute)
