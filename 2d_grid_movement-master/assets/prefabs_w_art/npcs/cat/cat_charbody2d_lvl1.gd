extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var sfx_moving: AudioStreamPlayer2D = $Audio_catwalking
@onready var sfx_ambient: AudioStreamPlayer2D = $Audio_meowpurr
@onready var timer: Timer = $Timer
@export var speed: int = 11000

# States
enum State { 
IDLE, 
MOVING, 
RUNNING_TO_PLAYER, 
AT_PLAYER, 
GUIDING_AWAY_PLAYER,
GUIDING_PIECE1,
GUIDING_PIECE2,
GUIDING_PIECE3left,
GUIDING_PIECE3up
}

var current_state = State.IDLE
var velocity_vector: Vector2 = Vector2.ZERO
var player: CharacterBody2D = null
var player_position: Vector2 = Vector2.ZERO
var player_closeness_trigger = 30
var mural: Node2D = null
var mural_position: Vector2 = Vector2.ZERO
var mural_closeness_trigger = 10
var one_time_trigger__timer = 0
var player_closeness_travel = 200
var player_farthest_dist_followPlayer = 300

var piece1: Node2D = null
var piece2: Node2D = null
var piece3left: Node2D = null
var piece3up: Node2D = null

@onready var navagent2d: NavigationAgent2D = $NavigationAgent2D

func _ready():
	Global.cat = self

	# setup vars that hold activators
	var zone_Activator2_Area2D = get_node_or_null("../Activator2_Area2D")  # Adjust path as needed
	if zone_Activator2_Area2D:
		zone_Activator2_Area2D.player_near_Activator2_Area2D.connect(_on_player_nearby_Activator2)
		print("Connected to signal: player_near_Activator2_Area2D")
	var zone_PlayerAtMural = get_node_or_null("../Activator3_Area2D")  # Adjust path as needed
	if zone_PlayerAtMural:
		zone_PlayerAtMural.player_near_Activator3_Area2D.connect(player_near_Activator3_Area2D)
		print("Connected to signal: player_near_Activator3_Area2D")
	var zone_PlayerAtPiece1 = get_node_or_null("../ActivatorPiece1_Area2D")  # Adjust path as needed
	if zone_PlayerAtPiece1:
		zone_PlayerAtPiece1.player_near_ActivatorPiece1_Area2D.connect(_on_player_at_Piece1)
		print("Connected to signal: player_near_ActivatorPiece1_Area2D")
	var zone_PlayerAtPiece2 = get_node_or_null("../ActivatorPiece2_Area2D")  # Adjust path as needed
	if zone_PlayerAtPiece2:
		zone_PlayerAtPiece2.player_near_ActivatorPiece2_Area2D.connect(_on_player_at_Piece2)
		print("Connected to signal: player_near_ActivatorPiece2_Area2D")
	var zone_PlayerAtPiece3left = get_node_or_null("../ActivatorPiece3left_Area2D")  # Adjust path as needed
	if zone_PlayerAtPiece3left:
		zone_PlayerAtPiece3left.player_near_ActivatorPiece3left_Area2D.connect(_on_player_at_Piece3left)
		print("Connected to signal: player_near_ActivatorPiece3left_Area2D")
		
	player = get_node_or_null("../Player_Char2D")
	if player:
		player_position = player.global_position
		print("player.global_position")
		print(player.global_position)
	else:
		print("Warning: No player position found!")
	mural = get_node_or_null("../Mural")
	if mural:
		mural_position = mural.global_position
	else:
		print("Warning: No mural position found!")
	
	piece1 = get_node_or_null("../Piece1cat")
	if !piece1:
		print("Warning: No piece1 position found!")
	piece2 = get_node_or_null("../Piece2cat")
	if !piece2:
		print("Warning: No piece2 position found!")
	piece3left = get_node_or_null("../Piece3leftcat")
	if !piece3left:
		print("Warning: No piece3left position found!")
	piece3up = get_node_or_null("../Piece3upcat")
	if !piece3up:
		print("Warning: No piece3up position found!")


# functions called (when activators are triggered)
func _on_player_nearby_Activator2():
	current_state = State.RUNNING_TO_PLAYER
	
func _on_timer_timeout():
	print("cat at player, cat moves to piece1")
	current_state = State.GUIDING_PIECE1
	
func player_near_Activator3_Area2D():
	print("")

func _on_player_at_Piece1():
	current_state = State.GUIDING_AWAY_PLAYER

func _on_player_at_Piece2():
	print("Player at piece1, cat moves to piece2")
	#current_state = State.GUIDING_PIECE3left
	
func _on_player_at_Piece3left():
	print("Player at piece3left, cat moves to piece3up")
	#current_state = State.GUIDING_PIECE3up


# reused helper functions for cat's states
func handle_animation(direction):
	print(direction)
	if direction == Vector2(0, 0):
		animated_sprite.animation = "idle"
		#sfx_moving.stop()
	else:
		#print("x=" +str(direction.x) +", y=" +str(direction.y) )
		if abs(direction.x) > (abs(direction.y) + 0.02):
			animated_sprite.animation = "move_left" if direction.x < 0 else "move_right"
		else:
			animated_sprite.animation = "move_up" if direction.y < 0 else "move_down"
		#sfx_moving.pitch_scale = randf_range(0.5, 1.5)  # Randomize pitch to make sound different
		#if not sfx_moving.playing:  # prevents overlapping sounds
			#sfx_moving.play()
	#animated_sprite.animation = "run_to_frog"
	animated_sprite.play()


func _physics_process(delta: float):
	if current_state == State.RUNNING_TO_PLAYER:
		# Move toward the player's location
		var direction = (player.global_position - global_position).normalized()
		velocity_vector = direction * speed * delta
		handle_animation(direction)
		#if direction == Vector2(0, 0):
			#animated_sprite.animation = "idle"
			#sfx_moving.stop()
		#else:
			##print("x=" +str(direction.x) +", y=" +str(direction.y) )
			#if abs(direction.x) > (abs(direction.y) +0.02):
				#animated_sprite.animation = "move_left" if direction.x < 0 else "move_right"
			#else:
				#animated_sprite.animation = "move_up" if direction.y < 0 else "move_down"
			#sfx_moving.pitch_scale = randf_range(0.5, 1.5)  # Randomize pitch to make sound different
			#if not sfx_moving.playing:  # prevents overlapping sounds
				#sfx_moving.play()
		## Set animation
		##animated_sprite.animation = "run_to_frog"
		#animated_sprite.play()
		# Adjust closeness threshold as needed
		if global_position.distance_to(player.global_position) < player_closeness_trigger:  
			print("Cat is at player!")
			current_state = State.AT_PLAYER
			#frog.visible = false
	elif current_state == State.AT_PLAYER:
		velocity_vector = Vector2.ZERO
		animated_sprite.animation = "idle"
		animated_sprite.play()
		if one_time_trigger__timer == 0:
			print("cat timer connected")
			timer.timeout.connect(_on_timer_timeout)
			one_time_trigger__timer = 1
			sfx_ambient.play()
			timer.start()
	elif current_state == State.GUIDING_AWAY_PLAYER:
		# Player too far, so cat follows player
		#if global_position.distance_to(player.global_position) > player_farthest_dist_followPlayer:
			###
		#var direction = (player.global_position - global_position).normalized()
		### new vector stuff
		var perpline_direction = (mural.global_position - player.global_position).normalized()
		var new_target_pos = player.global_position + (perpline_direction * player_closeness_travel)
		navagent2d.target_position = new_target_pos
		var direction = (new_target_pos - global_position).normalized()
		### end of new vector stuff
		velocity_vector = direction * speed * delta
		#var accel = 7
		#velocity_vector = velocity.lerp(direction * speed, accel * delta)
		if (direction == Vector2(0, 0)) or navagent2d.is_navigation_finished() or (global_position.distance_to(new_target_pos) < 1): ###
			velocity_vector = Vector2(0, 0) * speed * delta ###
			#velocity_vector = velocity.lerp(Vector2(0, 0) * speed, accel * delta)
			animated_sprite.animation = "idle"
			sfx_moving.stop()
		else:
			#print("x=" +str(direction.x) +", y=" +str(direction.y) )
			if abs(direction.x) > (abs(direction.y) +0.02):
				animated_sprite.animation = "move_left" if direction.x < 0 else "move_right"
			else:
				animated_sprite.animation = "move_up" if direction.y < 0 else "move_down"
			sfx_moving.pitch_scale = randf_range(0.5, 1.5)  # Randomize pitch to make sound different
			if not sfx_moving.playing:  # prevents overlapping sounds
				sfx_moving.play()
			###
			animated_sprite.play()
		# Player is within buffer zone of cat to piece, so cat stays put
		#elif ( global_position.distance_to(player.global_position) <= player_farthest_dist_followPlayer) and (global_position.distance_to(player.global_position) > player_closeness_travel):
			#velocity_vector = Vector2.ZERO
			#animated_sprite.animation = "idle"
			#animated_sprite.play()
		## Player is close to cat, so cat guides to piece
		#else: 
			## Move down to puzzle
			#var direction = (mural_position - global_position).normalized()
			##var direction = Vector2.DOWN
			#velocity_vector = direction * speed * delta
			#if direction == Vector2(0, 0):
				#animated_sprite.animation = "idle"
				#sfx_moving.stop()
			#else:
				#if abs(direction.x) > abs(direction.y):
					#animated_sprite.animation = "move_left" if direction.x < 0 else "move_right"
				#else:
					#animated_sprite.animation = "move_up" if direction.y < 0 else "move_down"
				#sfx_moving.pitch_scale = randf_range(0.5, 1.5)  # Randomize pitch to make sound different
				#if not sfx_moving.playing:  # prevents overlapping sounds
					#sfx_moving.play()
			## Set animation
			##animated_sprite.animation = "run_to_frog"
			#animated_sprite.play()
			if global_position.distance_to(mural.global_position) < mural_closeness_trigger:  
				print("Cat is at mural!")
				current_state = State.IDLE
	elif current_state == State.GUIDING_PIECE1:
		# Player too far, so cat follows player
		if global_position.distance_to(player.global_position) > player_farthest_dist_followPlayer:
			var direction = (player.global_position - global_position).normalized()
			velocity_vector = direction * speed * delta
			handle_animation(direction)
			#if direction == Vector2(0, 0):
				#animated_sprite.animation = "idle"
				#sfx_moving.stop()
			#else:
				##print("x=" +str(direction.x) +", y=" +str(direction.y) )
				#if abs(direction.x) > (abs(direction.y) +0.02):
					#animated_sprite.animation = "move_left" if direction.x < 0 else "move_right"
				#else:
					#animated_sprite.animation = "move_up" if direction.y < 0 else "move_down"
				#sfx_moving.pitch_scale = randf_range(0.5, 1.5)  # Randomize pitch to make sound different
				#if not sfx_moving.playing:  # prevents overlapping sounds
					#sfx_moving.play()
			#animated_sprite.play()
		# Player is within buffer zone of cat to piece, so cat stays put
		elif ( global_position.distance_to(player.global_position) <= player_farthest_dist_followPlayer) and (global_position.distance_to(player.global_position) > player_closeness_travel):
			velocity_vector = Vector2.ZERO
			animated_sprite.animation = "idle"
			animated_sprite.play()
		# Player is close to cat, so cat guides to piece
		else: 
			# Move down to puzzle
			var direction = (piece1.global_position - global_position).normalized()
			#var direction = Vector2.DOWN
			velocity_vector = direction * speed * delta
			handle_animation(direction)
			#if direction == Vector2(0, 0):
				#animated_sprite.animation = "idle"
				#sfx_moving.stop()
			#else:
				##print("x=" +str(direction.x) +", y=" +str(direction.y) )
				#if abs(direction.x) > (abs(direction.y) +0.02):
					#animated_sprite.animation = "move_left" if direction.x < 0 else "move_right"
				#else:
					#animated_sprite.animation = "move_up" if direction.y < 0 else "move_down"
				#sfx_moving.pitch_scale = randf_range(0.5, 1.5)  # Randomize pitch to make sound different
				#if not sfx_moving.playing:  # prevents overlapping sounds
					#sfx_moving.play()
			## Set animation
			##animated_sprite.animation = "run_to_frog"
			#animated_sprite.play()
			if global_position.distance_to(piece1.global_position) < mural_closeness_trigger:  
				print("Cat is at piece1!")
				current_state = State.IDLE
	elif current_state == State.GUIDING_PIECE2:
		if global_position.distance_to(player.global_position) > player_closeness_travel:
			velocity_vector = Vector2.ZERO
			animated_sprite.animation = "idle"
			animated_sprite.play()
		else: 
			# Move down to puzzle
			var direction = (piece2.global_position - global_position).normalized()
			#var direction = Vector2.DOWN
			velocity_vector = direction * speed * delta
			if direction == Vector2(0, 0):
				animated_sprite.animation = "idle"
				sfx_moving.stop()
			else:
				#print("x=" +str(direction.x) +", y=" +str(direction.y) )
				if abs(direction.x) > (abs(direction.y) +0.02):
					animated_sprite.animation = "move_left" if direction.x < 0 else "move_right"
				else:
					animated_sprite.animation = "move_up" if direction.y < 0 else "move_down"
				sfx_moving.pitch_scale = randf_range(0.5, 1.5)  # Randomize pitch to make sound different
				if not sfx_moving.playing:  # prevents overlapping sounds
					sfx_moving.play()
			# Set animation
			#animated_sprite.animation = "run_to_frog"
			animated_sprite.play()
			if global_position.distance_to(piece2.global_position) < mural_closeness_trigger:  
				print("Cat is at piece2!")
				current_state = State.IDLE
	elif current_state == State.GUIDING_PIECE3left:
		if global_position.distance_to(player.global_position) > player_closeness_travel:
			velocity_vector = Vector2.ZERO
			animated_sprite.animation = "idle"
			animated_sprite.play()
		else: 
			# Move down to puzzle
			var direction = (piece3left.global_position - global_position).normalized()
			#var direction = Vector2.DOWN
			velocity_vector = direction * speed * delta
			if direction == Vector2(0, 0):
				animated_sprite.animation = "idle"
				sfx_moving.stop()
			else:
				#print("x=" +str(direction.x) +", y=" +str(direction.y) )
				if abs(direction.x) > (abs(direction.y) +0.02):
					animated_sprite.animation = "move_left" if direction.x < 0 else "move_right"
				else:
					animated_sprite.animation = "move_up" if direction.y < 0 else "move_down"
				sfx_moving.pitch_scale = randf_range(0.5, 1.5)  # Randomize pitch to make sound different
				if not sfx_moving.playing:  # prevents overlapping sounds
					sfx_moving.play()
			# Set animation
			#animated_sprite.animation = "run_to_frog"
			animated_sprite.play()
			if global_position.distance_to(piece3left.global_position) < mural_closeness_trigger:  
				print("Cat is at piece3left!")
				current_state = State.IDLE
	elif current_state == State.GUIDING_PIECE3up:
		if global_position.distance_to(player.global_position) > player_closeness_travel:
			velocity_vector = Vector2.ZERO
			animated_sprite.animation = "idle"
			animated_sprite.play()
		else: 
			# Move down to puzzle
			var direction = (piece3up.global_position - global_position).normalized()
			#var direction = Vector2.DOWN
			velocity_vector = direction * speed * delta
			if direction == Vector2(0, 0):
				animated_sprite.animation = "idle"
				sfx_moving.stop()
			else:
				#print("x=" +str(direction.x) +", y=" +str(direction.y) )
				if abs(direction.x) > (abs(direction.y) +0.02):
					animated_sprite.animation = "move_left" if direction.x < 0 else "move_right"
				else:
					animated_sprite.animation = "move_up" if direction.y < 0 else "move_down"
				sfx_moving.pitch_scale = randf_range(0.5, 1.5)  # Randomize pitch to make sound different
				if not sfx_moving.playing:  # prevents overlapping sounds
					sfx_moving.play()
			# Set animation
			#animated_sprite.animation = "run_to_frog"
			animated_sprite.play()
			if global_position.distance_to(piece3up.global_position) < mural_closeness_trigger:  
				print("Cat is at piece3up!")
				current_state = State.IDLE
			
	else:
		# default state is IDLE (but that is infered from 'else'
		velocity_vector = Vector2.ZERO
		animated_sprite.animation = "idle"
		animated_sprite.play()

	# NOTE: 'velocity' is a builtin parameter for move_and_slide()
	velocity = velocity_vector
	move_and_slide()
	
