extends KinematicBody2D

var speed = 3
var costanteDelta = 100
var velocity = Vector2()
var danno = 1.5

func _physics_process(delta):
	var movement = speed * delta * velocity.normalized() * costanteDelta
	var collision = move_and_collide(movement)
	self.update_animations(velocity)
	if collision:
		#print(collision.collider.name)
		if not "Bullet" in collision.collider.name:
			if "Monster" in collision.collider.get_groups():
				collision.collider.diminuisciHP(danno, velocity)
			self.queue_free()

func setVelocity(v):
	velocity = v

func update_animations(velocity):
	if velocity.y == 1:
		self.rotation_degrees = 90
	elif velocity.y == -1:
		self.rotation_degrees = 270
	elif velocity.x == 1:
		self.rotation_degrees = 0
	elif velocity.x == -1:
		self.rotation_degrees = 180

func getPower():
	return danno

