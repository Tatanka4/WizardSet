extends KinematicBody2D

var movement = Vector2(1,0)
var speed = 2.5
var costanteDelta = 100
var hp = 1
var danno = 0.5


func _ready():
	randomize()
	self.scale.x = scale.x * -1
	
func _process(delta):
	if hp <= 0:
		self.queue_free()
		
	if $Timer.time_left == 0:
		$Timer.start()
		$Movement.play()
	
	var collision = move_and_collide(movement*speed*delta*costanteDelta)
	
	if collision:
		if "Tile" in collision.collider.get_groups():
			movement.x = movement.x * -1
			self.scale.x = scale.x * -1


func diminuisciHP(danno, velocity):
	hp -= danno
	#knock back ma non mi piace
	move_and_collide(velocity.normalized()*0.5*costanteDelta)
	$Damage.play()

func getDanno():
	return danno
