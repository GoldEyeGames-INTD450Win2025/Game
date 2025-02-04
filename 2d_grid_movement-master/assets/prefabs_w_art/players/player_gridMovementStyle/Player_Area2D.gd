extends Area2D

var animation_speed = 6
var moving = false
var tile_size = 64
var inputs = {
	"right": Vector2.RIGHT,
	"left": Vector2.LEFT,
	"up": Vector2.UP,
	"down": Vector2.DOWN
}

@onready var ray = $RayCast2d

func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size / 2
	
func _unhandled_input(event):
	if moving:
		return
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)
			
func move(dir):
	ray.target_position = inputs[dir] * tile_size
	ray.force_raycast_update()
	if ray.is_colliding() and ray.get_collider().name == "Door1":
		print("door here")
		get_tree().change_scene_to_file("res://scenes/Scene_NavMap_StartGame.tscn")
	if !ray.is_colliding():
		#position += inputs[dir] * tile_size
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", position + inputs[dir] * tile_size, 1.0 / animation_speed).set_trans(Tween.TRANS_SINE)
		moving = true
		#$AnimationPlayer.play(dir)
		await tween.finished
		moving = false

func _on_body_entered(body):
	if body.name == "Door1":
		print("door activated")
		get_tree().change_scene("res://scenes/Scene_NavMap_StartGame.tscn")
