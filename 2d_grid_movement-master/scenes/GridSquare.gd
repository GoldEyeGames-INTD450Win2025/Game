class_name GridSquare
extends StaticBody2D

var size = Vector2(128, 128)
var is_occupied = false
var grid_pos = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var collision = CollisionShape2D.new()
	var rect = RectangleShape2D.new()
	rect.extents = size * 0.5
	collision.set_shape(rect)
	add_child(collision)
	
	var color_rect = ColorRect.new()
	color_rect.size = size
	color_rect.set_color(Color(Color.GOLDENROD, 0.3))
	color_rect.position = Vector2(-size.x/2, -size.y/2)
	color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(color_rect)
	
	add_to_group("Dropable")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
