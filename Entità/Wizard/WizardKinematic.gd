extends KinematicBody2D


var costanteDelta = 100
var checkStart = true
var movement

var vita = 3 #Decidere se 3 o 5
var powerMagic = 0

signal infoRaccogliOggetto
signal rimuoviInfo
signal updateHP
signal updateStats

var dictBullet = {}
var bulletAttuale = 2
var speed = 3
var pause = false

func _ready():
	self.connect("updateStats", get_parent().get_node("GUI"), "_on_Wizard_updateStats")
	self.connect("infoRaccogliOggetto", get_parent().get_node("GUI"), "_on_Wizard_infoRaccogliOggetto")
	self.connect("rimuoviInfo", get_parent().get_node("GUI"), "_on_Wizard_rimuoviInfo")
	self.connect("updateHP", get_parent().get_node("GUI"), "_on_Wizard_updateHP")
	#Ci prendiamo il danno del proiettile da aggiungere alla GUI
	var scenaBullet = load("res://Entità/MagicBullet/MagicBullet.tscn")
	var magic_bullet = scenaBullet.instance()
	powerMagic = magic_bullet.getPower()
	if checkStart:
		aggiornaStats()
		checkStart = false
	dictBullet[1] = "res://Entità/MagicBullet/MagicBullet.tscn"
	dictBullet[2] = "res://Entità/FireBullet/FireBullet.tscn"
	pass

func _process(delta):
	
	var velocity = Vector2()
	
	if Input.is_action_pressed("ui_up"):
		velocity.y = -1
		$RayCast2D.cast_to = Vector2(0,-50)
	elif Input.is_action_pressed("ui_down"):
		velocity.y = 1
		$RayCast2D.cast_to = Vector2(0,50)
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -1
		$RayCast2D.cast_to = Vector2(-50,0)
	elif Input.is_action_pressed("ui_right"):
		velocity.x = 1
		$RayCast2D.cast_to = Vector2(50,0)
	elif Input.is_action_just_pressed("ui_cancel"):
		if pause:
			pause = false
			get_tree().paused = false
		else:
			pause = true
			get_tree().paused = true
	
	movement = velocity.normalized() * speed * delta * costanteDelta
	var collision = self.move_and_collide(movement)
	self.update_animations(velocity)
	
	#animaDanno()

	if $RayCast2D.is_colliding():
		var collider = $RayCast2D.get_collider()
		#print(collider," RAYCAST")
		if collider:
			if "Pozione" in collider.name:
				raccogliPozione(collider)
			elif "Pergamena" in collider.name:
				raccogliPergamena(collider)
			elif "Treasure" in collider.name:
				apriTesoro(collider)
			elif "Scale_Giu" in collider.name:
				scendiScale(collider)
			elif "Entrata" in collider.name:
				collider.entra($Wizard.animation)
			
	if collision:
		#print(collision.collider.get_groups())
		#print(collision," WIZARD")
		if ("Monster" in collision.collider.get_groups()):
				self.calcoloDanno(collision.collider.getDanno())
				#print("DANNO")
				#AGGIUNGERE COOLDOWN DANNO
				
		
	else:
		emit_signal("rimuoviInfo")
		#TODO: si aziona sempre
		
	if Input.is_key_pressed(KEY_Z) and $Magic_Cooldown.time_left == 0: 
		$Magic_Cooldown.start()
		var magicVelocity = createMagicVelocity()
		shoot_magic(magicVelocity)

func update_animations(velocity):
	if velocity.y == 1:
		$Wizard.play("Cammina_Dx")
	elif velocity.y == -1:
		$Wizard.play("Cammina_Up_Dx")
	elif velocity.x == 1:
		$Wizard.play("Cammina_Dx")
	elif velocity.x == -1:
		$Wizard.play("Cammina_Sx")
	
	if velocity == Vector2():
		if $Wizard.animation == "Cammina_Dx":
			$Wizard.play("Fermo_Dx")
		elif $Wizard.animation == "Cammina_Sx":
			$Wizard.play("Fermo_Sx")
		elif $Wizard.animation == "Cammina_Up_Dx":
			$Wizard.play("Fermo_Up_Dx")

func shoot_magic(velocity):
	var scenaBullet = load(dictBullet[bulletAttuale])
	var magic_bullet = scenaBullet.instance()
	#48 è un offset
	magic_bullet.position = self.position + $RayCast2D.cast_to.normalized()*45
	magic_bullet.setVelocity(velocity)
	self.playSound("Magia")
	get_parent().add_child(magic_bullet)

func createMagicVelocity():
	return Vector2($RayCast2D.cast_to.x/50, $RayCast2D.cast_to.y/50)
	

func calcoloDanno(danno):
	if danno > 0  and $Danno_Cooldown.time_left == 0:
		$Danno_Cooldown.start()
		vita -= danno
		self.playSound("Danno")
		#move_and_collide(movement * -1)
		emit_signal("updateHP", vita)
		if vita <= 0:
			SceneManager.clearSceneDict()
			SceneManager.goto_scene("res://Scene/Menu/Menu.tscn")
			self.queue_free()

		
	
func playSound(string):
	match string:
		"Magia":
			$Suoni/Magia.play()
		"Pozione":
			$Suoni/Pozione.play()
		"Danno":
			$Suoni/Danno.play()
		"Pergamena":
			$Suoni/Pergamena.play()
		"Chest":
			$Suoni/Chest.play()
			
	
func aggiornaStats():
	#print("Ciao")
	emit_signal("updateStats", speed, $Magic_Cooldown.wait_time, vita, powerMagic)

func raccogliPozione(collider):
	emit_signal("infoRaccogliOggetto", "oggetto")
	if  Input.is_action_just_pressed("ui_select"):
		self.playSound("Pozione")
		collider.esercitaEffetto(self)

func raccogliPergamena(collider):
	emit_signal("infoRaccogliOggetto", "oggetto")
	if  Input.is_action_just_pressed("ui_select"):
		self.playSound("Pergamena")
		collider.esercitaEffetto(self)

func apriTesoro(chest):
	if chest.chiusa:
		emit_signal("infoRaccogliOggetto", "oggetto")
		if  Input.is_action_just_pressed("ui_select"):
			self.playSound("Chest")
			chest.apriChest(self)

func scendiScale(collider):
	emit_signal("infoRaccogliOggetto", "scale")
	if  Input.is_action_just_pressed("ui_select"):
		#self.playSound("Pergamena")
		collider.effettuaAzione(vita)

func setIncantesimo(ind):
	bulletAttuale = ind

func getMagicCoolDown():
	return $Magic_Cooldown.wait_time

func setMagicCoolDown(newValue):
	$Magic_Cooldown.wait_time = newValue

func aggiornaStatLocali(w):
	bulletAttuale = w.bulletAttuale
	speed = w.speed
	setMagicCoolDown(w.getMagicCoolDown())
	powerMagic = w.powerMagic
	vita = w.vita
	aggiornaStats()

func animaDanno():
	if not $Danno_Cooldown.is_stopped():
		# Halve opacity every uneven frame counts
		self.modulate.a = 0 if Engine.get_frames_drawn() % 2 == 0 else 1.0
		self.modulate.g = 0 if Engine.get_frames_drawn() % 2 == 0 else 1.0
		self.modulate.b = 0 if Engine.get_frames_drawn() % 2 == 0 else 1.0
	else:
		# But beware... if the last damage frame is not even,
		# you risk to leave your character half transparent!
		# Preferably do this when you set your flag back to false
		self.modulate.a = 1.0
		self.modulate.g = 1.0
		self.modulate.b = 1.0
