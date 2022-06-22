extends Label

var builder = "DungeonBuilder/CostruzioneStanze.cl"
var required_room = "-c n=8"

func effettuaAzione():
	SceneManager.clearSceneDict()
	DungeonBuilder.generateDungeon(builder, required_room)
	print(DungeonBuilder.getSceneRoom())
	SceneManager.setWizard(SceneManager.load_node("res://Entità/Wizard/Wizard.tscn"))
	SceneManager.goto_scene("0")
