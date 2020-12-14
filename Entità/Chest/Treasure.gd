extends StaticBody2D

var chiusa = true

func _ready():

	pass

func apriChest(wizard):
	if chiusa:
		chiusa = false
		$AnimatedSprite.play("Aperta")
		spawnOggetto()

func spawnOggetto():
	var scene_oggetto = load(Utility.getObj(giveIndexObj()))
	var oggetto = scene_oggetto.instance()
	#48 è un offset
	oggetto.position = self.position + Vector2(-10,0)
	get_parent().add_child(oggetto)

func giveIndexObj():
	randomize()
	var percentuale = randi()% 100 + 1
	print(percentuale)
	var index = 0
	if percentuale <= 50:
		index = randi()%3
	elif percentuale <= 100:
		index = 3
	
	return index
