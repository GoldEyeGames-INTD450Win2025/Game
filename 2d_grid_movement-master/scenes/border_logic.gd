extends Node2D
var up_exited = true
var down_exited = true
var left_exited = true
var right_exited = true
var player = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var up = $Up
	var down = $Down
	var left = $Left
	var right = $Right
	
	up.body_entered.connect(_on_body_entered_up)
	down.body_entered.connect(_on_body_entered_down)
	left.body_entered.connect(_on_body_entered_left)
	right.body_entered.connect(_on_body_entered_right)
	
	up.body_exited.connect(_on_body_exited_up)
	down.body_exited.connect(_on_body_exited_down)
	left.body_exited.connect(_on_body_exited_left)
	right.body_exited.connect(_on_body_exited_right)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player != null:
		if not up_exited and Input.is_action_pressed("up"):
			var player_pos = player.global_position
			var off_set = _get_player_collision_box_size(player)
			player.global_position = Vector2(player_pos.x, (-1 * player_pos.y) + off_set)
			up_exited = true
			
		elif not down_exited and Input.is_action_pressed("down"):
			var player_pos = player.global_position
			var off_set = _get_player_collision_box_size(player)
			player.global_position = Vector2(player_pos.x, (-1 * player_pos.y) - off_set)
			down_exited = true
		
		if not left_exited and Input.is_action_pressed("left"):
			var player_pos = player.global_position
			var off_set = _get_player_collision_box_size(player)
			player.global_position = Vector2((-1 * player_pos.x) + off_set, player_pos.y)
			left_exited = true
				
		elif not right_exited and Input.is_action_pressed("right"):
			var player_pos = player.global_position
			var off_set = _get_player_collision_box_size(player)
			player.global_position = Vector2((-1 * player_pos.x) - off_set, player_pos.y)
			right_exited = true
		

func _is_player(body: Node2D) -> bool:
	return body.is_in_group("Player")

func _get_player_collision_box_size(player):
	# Find the CollisionShape2D within the player's node
	var collision_shape = player.get_node("CollisionShape2D")
	var rectangle_shape = collision_shape.shape
	var size = rectangle_shape.extents  # half of full size
	return size.x * 2

func _on_body_entered_left(body: Node2D) -> void:
	if _is_player(body):
		left_exited = false
		player = body

func _on_body_entered_right(body: Node2D) -> void:
	if _is_player(body):
		right_exited = false
		player = body

func _on_body_entered_up(body: Node2D) -> void:
	if _is_player(body):
		up_exited = false
		player = body

func _on_body_entered_down(body: Node2D) -> void:
	if _is_player(body):
		down_exited = false
		player = body

func _on_body_exited_up(body: Node2D) -> void:
	if _is_player(body):
		up_exited = true

func _on_body_exited_down(body: Node2D) -> void:
	if _is_player(body):
		down_exited = true

func _on_body_exited_left(body: Node2D) -> void:
	if _is_player(body):
		left_exited = true

func _on_body_exited_right(body: Node2D) -> void:
	if _is_player(body):
		right_exited = true
