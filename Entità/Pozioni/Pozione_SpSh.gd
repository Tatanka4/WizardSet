extends StaticBody2D


func _ready():
	pass # Replace with function body.


#func _process(delta):
#	pass

func esercitaEffetto(mago):
	if mago.getMagicCoolDown() > 0.1:
		mago.setMagicCoolDown( mago.getMagicCoolDown() - 0.05)
		mago.aggiornaStats()
	self.queue_free()
		
