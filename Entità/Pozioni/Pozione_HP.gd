extends StaticBody2D


func _ready():
	pass # Replace with function body.


#func _process(delta):
#	pass

func esercitaEffetto(mago):
	if mago.vita < 3:
		mago.vita += 1
		if mago.vita > 3:
			mago.vita = 3
		mago.aggiornaStats()
	self.queue_free()
		
		#print(mago.vita)
