# class extends:
extends CharacterBody2D
# vars:
enum State { TRAVEL, SCARED }
@export var speed: int = 300
@onready var animated_sprited_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_sfx_walking: AudioStreamPlayer2D = $Audio_SFX_Walking
@onready var random_direction: Vector2 = Vector2.ZERO
@onready var timer: Timer = $Timer
@onready var vector: Vector2 = Vector2.ZERO
@onready var current_state = State.TRAVEL
# function code:
func _ready():
	# Connect the timer for normal movement
	timer.timeout.connect(_on_timer_timeout)
	# Find the ScareZone (Area2D) and connect its signal
	var scare_zone = get_node_or_null("../Activator1_Area2D")  # Adjust path as needed
	if scare_zone:
		scare_zone.player_near_frog.connect(_on_player_nearby)
		print("Connected to ScareZone signal")
func _on_timer_timeout():
	if current_state == State.TRAVEL:
		# Randomly choose between left, right, or zero
		var random_choice = randi_range(0, 2)
		if random_choice == 0:
			random_direction = Vector2.LEFT
		elif random_choice == 1:
			random_direction = Vector2.RIGHT
		else:
			random_direction = Vector2.ZERO
	else: # scared state
		random_direction = Vector2.RIGHT
func get_npc_input(delta: float) -> void:
	vector = random_direction * speed * delta
	if random_direction == Vector2(0, 0):
		animated_sprited_2d.animation = "idle"
		audio_sfx_walking.stop()
	else:
		if abs(vector.x) > abs(vector.y):
			if current_state == State.SCARED:
				animated_sprited_2d.animation = "run_right_scared"
			else: 
				animated_sprited_2d.animation = "run_left" if vector.x < 0 else "run_right"
		else:
			pass
			#animated_sprited_2d.animation = "run_up" if vector.y < 0 else "run_down"
		audio_sfx_walking.pitch_scale = randf_range(0.5, 1.5)  # Randomize pitch to make sound different
		if not audio_sfx_walking.playing:  # prevents overlapping sounds
			audio_sfx_walking.play()
	animated_sprited_2d.play()
	velocity = vector #* velocity is a property of move_and_slide()
func _physics_process(delta: float) -> void: # like "update every frame (i.e. delta)"
	get_npc_input(delta)
	move_and_slide()
func _on_player_nearby(): # Function that is triggered by the signal
	print("Frog is scared!")
	current_state = State.SCARED
