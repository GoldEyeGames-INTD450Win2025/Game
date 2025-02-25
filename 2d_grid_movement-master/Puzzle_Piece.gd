class_name PuzzlePiece
extends Node2D

var draggable = false
var is_inside_dropabale = false
var currently_being_dragged = false
var anker_ref
var body_list = []
var offset: Vector2
var initialPos: Vector2

func _ready():
	self.z_index = 5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for body in body_list:
		if abs(body.global_position.x - global_position.x) < (128 * 0.4) and abs(body.global_position.y - global_position.y) < (128 * 0.4):
			is_inside_dropabale = true
			body.modulate = Color(Color.GRAY, 1)
			anker_ref = body
				
	if draggable:
		if Input.is_action_just_pressed("left_click"):
			Global.is_dragging = true
			offset = get_global_mouse_position() - global_position
			currently_being_dragged = true
			
		elif Input.is_action_pressed("left_click"):
			global_position = get_global_mouse_position() - offset
			z_index = 10
			
		if Input.is_action_just_released("left_click"):
			Global.is_dragging = false
			currently_being_dragged = false
			
			var tween = get_tree().create_tween()
			if is_inside_dropabale:
				tween.tween_property(self, "global_position", anker_ref.global_position, 0.05).set_ease(Tween.EASE_OUT)
				initialPos = anker_ref.position
				await tween.finished
			else:
				tween.tween_property(self, "global_position", initialPos, 0.05).set_ease(Tween.EASE_OUT)
				await tween.finished
			self.z_index = 5


func _on_area_2d_mouse_entered() -> void:
	if not Global.is_dragging:
		draggable = true
		initialPos = global_position

# need to fix, is broken
func _on_area_2d_mouse_exited() -> void:
	draggable = false
	if currently_being_dragged:
		Global.is_dragging = false
		currently_being_dragged = false
		
		var tween = get_tree().create_tween()
		if is_inside_dropabale:
			tween.tween_property(self, "global_position", anker_ref.global_position, 0.05).set_ease(Tween.EASE_OUT)
			initialPos = anker_ref.position
			await tween.finished
		else:
			tween.tween_property(self, "global_position", initialPos, 0.05).set_ease(Tween.EASE_OUT)
			await tween.finished
		self.z_index = 5


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Dropable"):
		body_list.append(body)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Dropable"):
		for i in body_list.size():
			if body == body_list[i]:
				body_list.remove_at(i)
				body.modulate = Color(Color.DIM_GRAY, 1)
				if body == anker_ref:
					is_inside_dropabale = false
				break

func _connect():
	var area = get_child(0)
	area.mouse_entered.connect(_on_area_2d_mouse_entered)
	area.mouse_exited.connect(_on_area_2d_mouse_exited)
	area.body_entered.connect(_on_area_2d_body_entered)
	area.body_exited.connect(_on_area_2d_body_exited)
