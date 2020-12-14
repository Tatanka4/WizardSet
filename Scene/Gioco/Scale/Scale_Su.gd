extends StaticBody2D

var builder = "DungeonBuilder\\CostruzioneStanze.clingo"
var required_room = "-c required_rooms=8"

func effettuaAzione():
	SceneManager.clearSceneDict()
	DungeonBuilder.generateDungeon(builder, required_room)
	SceneManager.goto_scene("res://Scene/Gioco/Stanze/Room1.tscn")
