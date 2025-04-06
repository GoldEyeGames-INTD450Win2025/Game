extends CharacterBody2D

@export var speed: int = 600
@onready var animated_sprited_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var sfx_footsteps = $Footsteps
var is_playing_footsteps = false

func get_player_input(delta: float) -> void:
	var vector: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = vector * speed * delta
	if Input.is_action_pressed("shift"):
		velocity *= 1.5
	if vector == Vector2(0, 0):
		animated_sprited_2d.animation = "idle"
		sfx_footsteps.footsteps_stop()
		is_playing_footsteps = false
	else:
		if abs(vector.x) > abs(vector.y):
			animated_sprited_2d.animation = "run_left" if vector.x < 0 else "run_right"
		else:
			animated_sprited_2d.animation = "run_up" if vector.y < 0 else "run_down"
		
		if not is_playing_footsteps:
			is_playing_footsteps = true
			await sfx_footsteps.footsteps_play()
			is_playing_footsteps = false
	animated_sprited_2d.play()


func _physics_process(delta: float) -> void:
	if not Global.puzzle_open and not Global.pause_menu_open and not Global.dialogue_box_open:
		get_player_input(delta)
		move_and_slide()
	else:
		animated_sprited_2d.animation = "idle"
		sfx_footsteps.footsteps_stop()
		is_playing_footsteps = false
