# extends CharacterBody2D
# const SPEED = 300.0
# const JUMP_VELOCITY = -400.0
# func _physics_process(delta: float) -> void:
# 	# Add the gravity.
# 	if not is_on_floor():
# 		velocity += get_gravity() * delta
# 	# Handle jump.
# 	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
# 		velocity.y = JUMP_VELOCITY
# 	# Get the input direction and handle the movement/deceleration.
# 	# As good practice, you should replace UI actions with custom gameplay actions.
# 	var direction := Input.get_axis("ui_left", "ui_right")
# 	if direction:
# 		velocity.x = direction * SPEED
# 	else:
# 		velocity.x = move_toward(velocity.x, 0, SPEED)
# 	move_and_slide()




# extends CharacterBody2D
# ## Speed in pixels per second.
# @export_range(0, 1000) var speed := 600
# func _physics_process(_delta: float) -> void:
# 	get_player_input()
# 	move_and_slide()
# func get_player_input() -> void:
# 	var vector := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
# 	velocity = vector * speed


## ref: https://www.youtube.com/watch?v=mxtVnC6eCh4&list=PLDIFASQjsoonh1hYFqp2oSP3SxapgzOa5&index=6
#extends CharacterBody2D
#var character_direction : Vector2
#var character_speed := 9000
#func _physics_process(delta: float) -> void:
	#if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down"):
		#character_direction.x = Input.get_axis("ui_left", "ui_right")
		#character_direction.y = Input.get_axis("ui_up", "ui_down")
		#character_direction = character_direction.normalized()
		#velocity = character_direction * speed * delta
	#else:
		#velocity = Vector2(0, 0)
	#move_and_slide()


# class extends:
extends CharacterBody2D
# vars:
@export var speed: int = 600
@onready var animated_sprited_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_sfx_walking: AudioStreamPlayer2D = $Audio_SFX_Walking
# function code:
func get_player_input(delta: float) -> void:
	var vector: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = vector * speed * delta
	if vector == Vector2(0, 0):
		animated_sprited_2d.animation = "idle"
		audio_sfx_walking.stop()
	else:
		if abs(vector.x) > abs(vector.y):
			animated_sprited_2d.animation = "run_left" if vector.x < 0 else "run_right"
		else:
			animated_sprited_2d.animation = "run_up" if vector.y < 0 else "run_down"
		audio_sfx_walking.pitch_scale = randf_range(0.5, 1.5)  # Randomize pitch to make sound different
		if not audio_sfx_walking.playing:  # prevents overlapping sounds
			audio_sfx_walking.play()
	animated_sprited_2d.play()
func _physics_process(delta: float) -> void: # like "update every frame (i.e. delta)"
	get_player_input(delta)
	move_and_slide()
