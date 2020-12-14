extends Area2D

var ferma = true
var aperto = false #false/true = chiuso/aperto
var body = null
var bodyOnArea = false

func _ready():
	pass # Replace with function body.


func _process(delta):
	if $Timer.time_left == 0:
		$Timer.start()
		if not ferma:
			match aperto:
				true:
					$AnimatedSprite.play("Chiudendo")
					yield(get_node("AnimatedSprite"), "animation_finished")
					aperto = false
				false:
					$AnimatedSprite.play("Aprendo")
					aperto = true
			ferma = true
		else:
			match aperto:
				true:
					$AnimatedSprite.play("FermaAperta")
				false:
					$AnimatedSprite.play("FermoChiusa")
			ferma = false
	
	if body:
		if "Wizard" in body.name and bodyOnArea:
			body.calcoloDanno(self.getDanno())

func getDanno():
	if aperto:
		#print("Aperto")
		return 0.5
	else:
		#print("Chiuso")
		return 0

func setTimer(time):
	$Timer.wait_time = time


func _on_Spuntoni_body_entered(b):
	body = b
	bodyOnArea = true


func _on_Spuntoni_body_exited(body):
	body = null
	bodyOnArea = false
