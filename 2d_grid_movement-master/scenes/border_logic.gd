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
func _process(_delta: float) -> void:
	if player != null:
		var cat_distance
		if Global.cat != null:
			cat_distance = Global.cat.global_position - player.global_position
		if not up_exited and player.velocity.y < 0:
			var player_pos = player.global_position
			player.global_position = Vector2(player_pos.x, (-1 * player_pos.y))# - 8 + 128 +32)
			up_exited = true
			
		elif not down_exited and player.velocity.y > 0:
			var player_pos = player.global_position
			player.global_position = Vector2(player_pos.x, (-1 * player_pos.y))# + 8 + 128 + 16 + 8 -4)
			down_exited = true
		
		if not left_exited and player.velocity.x < 0:
			var player_pos = player.global_position
			player.global_position = Vector2((-1 * player_pos.x) + 32 +8, player_pos.y)
			left_exited = true
				
		elif not right_exited and player.velocity.x > 0:
			var player_pos = player.global_position
			player.global_position = Vector2((-1 * player_pos.x) - 16 , player_pos.y)
			right_exited = true
		if Global.cat != null:
			Global.cat.global_position = player.global_position + cat_distance
		
		
		

func _is_player(body: Node2D) -> bool:
	return body.is_in_group("Player")

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
