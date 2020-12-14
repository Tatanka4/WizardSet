extends Label

var builder = "DungeonBuilder/CostruzioneStanze.cl"
var required_room = "-c required_rooms=8"

func effettuaAzione():
	SceneManager.clearSceneDict()
	DungeonBuilder.generateDungeon(builder, required_room)
	SceneManager.setWizard(SceneManager.load_node("res://Entità/Wizard/Wizard.tscn"))
	SceneManager.goto_scene("res://Scene/Gioco/Stanze/Room1.tscn")
