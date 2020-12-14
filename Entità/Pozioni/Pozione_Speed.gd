extends StaticBody2D


func _ready():
	pass # Replace with function body.


#func _process(delta):
#	pass

func esercitaEffetto(mago):
	if mago.speed < 5:
		mago.speed += 0.1
		mago.aggiornaStats()
	self.queue_free()
