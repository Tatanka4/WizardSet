extends KinematicBody2D

var movement = Vector2(1,0)
var movMagic = Vector2(1,1)
var speed = 3
var costanteDelta = 100
var hp = 5
var danno = 0.5

var pattern = 0

func _ready():
	randomize()
	get_parent().get_node("TileMap/EntrataSud").setLock(true)
	
func _process(delta):
	if hp <= 0:
		get_parent().get_node("TileMap/EntrataSud").setLock(false)
		caricaScale()
		self.queue_free()

	if $Pattern.time_left == 0:
		pattern += 1
		if pattern == 2:
			pattern = 0
		#print("CAMBIO PATTERN ",str(pattern))
		cambioPattern()
		$Pattern.start()
	
	if $Magic_Cooldown.time_left == 0: 
		$Magic_Cooldown.start()
		var magicVelocity = createMagicVelocity()
		shoot_magic(magicVelocity)
		
	var collision = move_and_collide(movement*speed*delta*costanteDelta)
	if collision:
		if "Tile" in collision.collider.get_groups() or "Wizard" in collision.collider.name:
			movement = movement * -1
			if movement == Vector2(1,0):
				self.scale.x = scale.x * -1

func cambioPattern():
	randomize()
	var rand = randi()%2
	match pattern:
			0:	#Cammina Orizzontale
				if rand == 0:
					self.global_position = Vector2(160,160)
					$Rouge.play("Cammina_Dx")
					movMagic = Vector2(-1,-1)
					$RayCast2D.cast_to = Vector2(0, 50)
				else:
					self.global_position = Vector2(160,480)
					$Rouge.play("Cammina_Up_Sx")
					movMagic = Vector2(1,-1)
					$RayCast2D.cast_to = Vector2(0,-50)
				movement = Vector2(1,0)
			1:	#Cammina Verticale
				if rand == 0:
					self.global_position = Vector2(160,160)
					$Rouge.play("Cammina_Dx")
					movMagic = Vector2(1,1)
					$RayCast2D.cast_to = Vector2(50,0 )
				else:
					self.global_position = Vector2(864,160)
					$Rouge.play("Cammina_Sx")
					movMagic = Vector2(-1,1)
					$RayCast2D.cast_to = Vector2(-50, 0)
				movement = Vector2(0,1)

func createMagicVelocity():
	return Vector2($RayCast2D.cast_to.x/50, $RayCast2D.cast_to.y/50)

func shoot_magic(velocity):
	var scenaBullet = load("res://Entità/Rouge/RougeMagic.tscn")
	var magic_bullet = scenaBullet.instance()
	#48 è un offset
	magic_bullet.position = self.position + $RayCast2D.cast_to.normalized()*48
	magic_bullet.setVelocity(velocity)
	#self.playSound("Magia")
	get_parent().add_child(magic_bullet)

func diminuisciHP(danno, velocity):
	hp -= danno
	print("DANNO")
	get_parent().get_node("GUI").get_node("Boss_Health").value = hp*20

func getDanno():
	return danno

func caricaScale():
	var scenaScale = load("res://Scene/Gioco/Scale/Scale_Giu.tscn")
	var scale = scenaScale.instance()
	if get_parent().get_node("Wizard").position != Vector2(512,416):
		scale.position = Vector2(512,416)
	else:
		scale.position = Vector2(512,224)
	scale.scale = Vector2(2,2)
	#print("CIAO")
	get_parent().add_child(scale)
	get_parent().move_child(get_parent().get_node("Scale_Giu"), get_parent().get_node("Wizard").get_index() - 1)
	#print(get_parent().get_node("Wizard").get_index())
	#print("CIAO2")
