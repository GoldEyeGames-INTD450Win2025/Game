extends CharacterBody2D


#extends KinematicBody2D

# these weights where defined through
# trial and error. You can play with them
# to check how they affect the flock.
const SEPARATION_WEIGHT = 0.01
const ALIGNMENT_WEIGHT = 0.05
const COHESION_WEIGHT = 0.0001


var _max_speed = 2
var _speed = 1
var _direction = Vector2(0, 1)
var _separation_distance = 20

var _local_flockmates = []

@onready var animation = $AnimatedSprite2D

func _physics_process(_delta):
	#self.rotation = Vector2(0, 1).angle_to(_direction)
	var collision = self.move_and_collide(_direction * _speed)
	if collision:
		#if collision.collider is TileMap:
			#_direction = _collision_reaction_direction(collision)
		var normal = collision.get_normal()  # Get the surface normal
		_direction = _direction.bounce(normal)  # Reflect the direction
	else:
		_direction = _flock_direction()
	
	if _direction.x > 0:
		animation.play("move_right")
	else:
		animation.play("move_left")



# Inverts the direction when hitting a collider.
# This implementation handles colliding with Tilemaps specifically.
func _collision_reaction_direction(collision):
	return (collision.position - collision.normal).direction_to(self.position)


# This function is pretty much all you need for calculating
# the flocking movement
func _flock_direction():
	var separation = Vector2()
	var heading = _direction
	var cohesion = Vector2()

	for flockmate in _local_flockmates:
		heading += flockmate.get_direction()
		cohesion += flockmate.position

		var distance = self.position.distance_to(flockmate.position)

		if distance < _separation_distance:
			separation -= (flockmate.position - self.position).normalized() * (_separation_distance / distance * _speed)

	if _local_flockmates.size() > 0:
		heading /= _local_flockmates.size()
		cohesion /= _local_flockmates.size()
		var center_direction = self.position.direction_to(cohesion)
		var center_speed = _max_speed * self.position.distance_to(cohesion) / $Area2D/CollisionShape2D.shape.radius
		cohesion = center_direction * center_speed

	return (
		_direction +
		separation * SEPARATION_WEIGHT +
		heading * ALIGNMENT_WEIGHT +
		cohesion * COHESION_WEIGHT
	).limit_length(_max_speed)


func get_direction():
	return _direction


func set_direction(direction):
	_direction = direction


#func _on_detection_radius_body_entered(body):
	#if body == self:
		#return
		#print(body.name + _local_flockmates)
#
	#if body.is_in_group("boid"):
		#_local_flockmates.push_back(body)
#
#
#func _on_detection_radius_body_exited(body):
	#if body.is_in_group("boid"):
		#_local_flockmates.erase(body)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == self:
		#print(body.name + _local_flockmates)
		return

	if body.is_in_group("boid"):
		_local_flockmates.push_back(body)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("boid"):
		_local_flockmates.erase(body)
