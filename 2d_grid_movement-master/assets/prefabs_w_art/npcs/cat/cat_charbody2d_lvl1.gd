extends CharacterBody2D

@export var speed: int = 11000
@onready var timer: Timer = $Timer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var sfx_ambient: AudioStreamPlayer2D = $Audio_meowpurr
@onready var navagent2d: NavigationAgent2D = $NavigationAgent2D

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
var animation_timer = 0.0
var animation_timer_limit = 0.25
var piece1: Node2D = null
var piece2: Node2D = null
var piece3left: Node2D = null
var piece3up: Node2D = null
var last_position

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

func _on_player_at_Piece1():
	current_state = State.GUIDING_AWAY_PLAYER

func player_near_Activator3_Area2D():
	print("")

func _on_player_at_Piece2():
	print("Player at piece1, cat moves to piece2")
	#current_state = State.GUIDING_PIECE3left

func _on_player_at_Piece3left():
	print("Player at piece3left, cat moves to piece3up")
	#current_state = State.GUIDING_PIECE3up

func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2):
	velocity = safe_velocity


func handle_animation(direction):
	if direction == Vector2(0, 0):
		animated_sprite.animation = "idle"
	else:
		if abs(direction.x) > (abs(direction.y) + 0.02):
			animated_sprite.animation = "move_left" if direction.x < 0 else "move_right"
		else:
			animated_sprite.animation = "move_up" if direction.y < 0 else "move_down"
	animated_sprite.play()

func handle_movement_animation(item_target_position, delta, new_speed, stayput):
	#mural_position = mural.global_position
	player_position = player.global_position
	var cat2player_distance = global_position.distance_to(player.global_position)

	# person too far from cat: cat follows person
	if cat2player_distance > player_farthest_dist_followPlayer :
		navagent2d.target_position = player_position
		#print ("person too far from cat: cat follows person")
	# person and cat really close: cat moves toward mural (to guide player)
	elif cat2player_distance <  player_closeness_travel:
		navagent2d.target_position = item_target_position
		#print ("person and cat really close: cat moves toward mural (to guide player)")
	# person and cat close-ish (within buffer zone): cat doesn't move
	else:
		navagent2d.target_position = global_position
		#print ("person and cat close-ish (within buffer zone): cat doesn't move")
	last_position = navagent2d.target_position
	var current_agent_position = global_position
	var next_path_position = navagent2d.get_next_path_position()
	var direction_vector : Vector2 = current_agent_position.direction_to(next_path_position)
	var direction_angle = direction_vector.angle()
	
	if global_position.distance_to(last_position) < 5: #i think(?) this prevents stuttering
		velocity_vector = Vector2.ZERO
	else:
		velocity_vector = direction_vector * new_speed * delta

	animation_timer += delta
	if navagent2d.is_navigation_finished():
		if animation_timer > animation_timer_limit:
			animated_sprite.animation = "idle"
			animated_sprite.play()
			animation_timer = 0
		return
	
	if navagent2d.avoidance_enabled:
		navagent2d.set_velocity(velocity_vector)
	else:
		_on_navigation_agent_2d_velocity_computed(velocity_vector) # i.e. velocity = new velocity
	
	# right is between -pi/3 and pi/3
	# up ±30 degrees (-pi/2)
	var up_upper_edge = (-1 * PI / 3)
	var up_lower_edge = (-2 * PI / 3)
	# left is between (-2pi/3 and -pi ) and (2pi/3 and pi ) * use as else statement
	# down ±30 degrees (pi/2)
	var down_upper_edge = (2 * PI / 3)
	var down_lower_edge = (1 * PI / 3)
	# switch animation only if timer exceeds delay
	if animation_timer >= animation_timer_limit:
		if ( direction_angle > up_upper_edge) and ( direction_angle < down_lower_edge) :
			animated_sprite.animation = "move_right"
		elif ( direction_angle <= up_upper_edge) and ( direction_angle >= up_lower_edge):
			animated_sprite.animation = "move_up"
		elif ( direction_angle <= down_upper_edge) and ( direction_angle >= up_lower_edge):
			animated_sprite.animation = "move_down"
		else:
			animated_sprite.animation = "move_left"
		animated_sprite.play()
		animation_timer = 0.0

	if stayput == true:
		if global_position.distance_to(item_target_position) < mural_closeness_trigger:  
			print("Cat is at mural!")
			current_state = State.IDLE #uncomment if you want cat to stay at mural indefinitely

func _physics_process(delta: float):
	var new_speed = speed
	if Input.is_action_pressed("shift"):
		new_speed *= 1.5

	if current_state == State.RUNNING_TO_PLAYER:
		var direction = (player.global_position - global_position).normalized()
		velocity_vector = direction * speed * delta
		handle_animation(direction)
		if global_position.distance_to(player.global_position) < player_closeness_trigger:  
			print("Cat is at player!")
			current_state = State.AT_PLAYER

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
	elif current_state == State.GUIDING_PIECE1:
		handle_movement_animation(piece1.global_position, delta, new_speed, true)
	elif current_state == State.GUIDING_AWAY_PLAYER:
		handle_movement_animation(mural.global_position, delta, new_speed, false)
	#elif current_state == State.GUIDING_PIECE2:
		#handle_movement_animation(delta, new_speed)
	#elif current_state == State.GUIDING_PIECE3left:
		#handle_movement_animation(delta, new_speed)
	#elif current_state == State.GUIDING_PIECE3up:
		#handle_movement_animation(delta, new_speed)
	else:
		# default state is IDLE (but that is infered from 'else'
		velocity_vector = Vector2.ZERO
		animated_sprite.animation = "idle"
		animated_sprite.play()

	# NOTE: 'velocity' is a builtin parameter for move_and_slide()
	velocity = velocity_vector
	move_and_slide()
	
