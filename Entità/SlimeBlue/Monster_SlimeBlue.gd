extends KinematicBody2D

var movement = Vector2()
var speed = 0.25
var costanteDelta = 100
var hp = 1
var danno = 0.5

func _ready():
	randomize()
	
func _process(delta):
	if hp <= 0:
		self.queue_free()
	
	if $Timer.time_left == 0:
		$Timer.start()
		if randi() % 2 == 0:
			movement = Vector2()
		else:
			movement = getRandomMove()
			$Movement.play()
	
	move_and_collide(movement*speed*delta*costanteDelta)
	
func getRandomMove():
	var dir = Vector2()
	var rand = randi()% 4 + 1
	
	match rand:
		1:
			dir.x = -1
			self.scale.x = self.scale.x * -1
		2:
			dir.x = 1
			self.scale.x = self.scale.x * -1
		3:
			dir.y = -1
		4:
			dir.y = 1
	
	return dir

func diminuisciHP(danno, velocity):
	hp -= danno
	#knock back ma non mi piace
	move_and_collide(velocity.normalized()*speed*costanteDelta)
	$Damage.play()

func getDanno():
	return danno
