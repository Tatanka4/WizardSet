extends Node2D

func _ready():
	var childrens = []
	for c in get_node("TileMap").get_children():
		childrens.append(c)
	
	#FLAG ASP: Attivati quando la vita è minore di 2
	if int(DungeonBuilder.getSpawnPozione()) == 1:
		#print(childrens)
		#PRIMO FLAG ASP: Spawna pozione HP
		if "Room18" in self.name:
			var scenaPozione = load("res://Entità/Pozioni/Pozione_HP.tscn")
			var pozione = scenaPozione.instance()
			pozione.position = Vector2(304,80)
			get_node("TileMap").add_child(pozione)
		#SECONDO FLAG ASP: Rallenta il cooldown degli spuntoni
		for c in childrens:
			if "Spuntoni" in c.name:
				c.setTimer(2)
			

func init(entrata):
	$Wizard.aggiornaStatLocali(SceneManager.getWizard())
	match entrata:
		"sud":
			$Wizard.global_position = $TileMap/EntrataSud.global_position - Vector2(0,50)
			$Wizard.get_node("Wizard").play("Cammina_Up_Dx")
		"nord":
			$Wizard.global_position = $TileMap/EntrataNord.global_position + Vector2(0,50)
			$Wizard.get_node("Wizard").play("Cammina_Dx")
		"est":
			$Wizard.global_position = $TileMap/EntrataEst.global_position - Vector2(50,0)
			$Wizard.get_node("Wizard").play("Cammina_Sx")
		"ovest":
			$Wizard.global_position = $TileMap/EntrataOvest.global_position + Vector2(50,0)
			$Wizard.get_node("Wizard").play("Cammina_Dx")
	


