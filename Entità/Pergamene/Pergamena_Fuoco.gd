extends StaticBody2D

func _ready():
	pass

func esercitaEffetto(mago):
	mago.setIncantesimo(2)
	self.queue_free()
