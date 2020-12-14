extends KinematicBody2D

var speed = 3
var costanteDelta = 100
var velocity = Vector2(1,1)
var danno = 0.5

func _physics_process(delta):
	var movement = speed * delta * velocity.normalized() * costanteDelta
	var collision = move_and_collide(movement)
	if collision:
		#print(collision.collider.name)
		if collision.collider.name != "MagicBullet":
			if "Wizard" in collision.collider.name:
				collision.collider.calcoloDanno(danno)
			self.queue_free()

func setVelocity(v):
	velocity = v

func getPower():
	return danno

