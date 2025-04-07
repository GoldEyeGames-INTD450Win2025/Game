# class extends:
extends CharacterBody2D
# vars:
@export var speed: int = 600
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
#@onready var audio_sfx_walking: AudioStreamPlayer2D = $Audio_SFX_Walking
@onready var audio_sfx_walking = $SFX_Footsteps
var is_playing_footsteps = false
@onready var sprite_still = $AnimatedSprite2D_Still
@onready var transition_time = 6.0

func _ready() -> void:
	sprite_still.hide() # used as sprite for editor (when real sprite is using 'dissolved' shader)
	# do material phase effect from shader, use tween to change parameter
	var tween = get_tree().create_tween()
	tween.tween_property(animated_sprite_2d.material, "shader_parameter/DissolveValue", 1, transition_time).set_trans(Tween.TRANS_LINEAR)
	
# function code:
func get_player_input(delta: float) -> void:
	var vector: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = vector * speed * delta
	if Input.is_action_pressed("shift"):
		velocity *= 1.5
		
	if vector == Vector2(0, 0):
		animated_sprite_2d.animation = "idle"
		audio_sfx_walking.footsteps_stop()
		is_playing_footsteps = false
	else:
		if abs(vector.x) > abs(vector.y):
			animated_sprite_2d.animation = "run_left" if vector.x < 0 else "run_right"
		else:
			animated_sprite_2d.animation = "run_up" if vector.y < 0 else "run_down"
		#audio_sfx_walking.pitch_scale = randf_range(0.5, 1.5)  # Randomize pitch to make sound different
		#if not audio_sfx_walking.playing:  # prevents overlapping sounds
			#audio_sfx_walking.footsteps_play()
		#audio_sfx_walking.footsteps_play()
		if not is_playing_footsteps:
			is_playing_footsteps = true
			await audio_sfx_walking.footsteps_play()
			is_playing_footsteps = false
	animated_sprite_2d.play()
	
func _physics_process(delta: float) -> void: # like "update every frame (i.e. delta)"
	if not Global.puzzle_open and not Global.pause_menu_open and not Global.dialogue_box_open:
		get_player_input(delta)
		move_and_slide()
	else:
		animated_sprite_2d.animation = "idle"
		audio_sfx_walking.footsteps_stop()
		is_playing_footsteps = false
