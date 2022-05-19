extends StaticBody2D

var builder = "DungeonBuilder\\CostruzioneStanze2.cl"
var required_room = "-c required_rooms=8"

func effettuaAzione(vita):
	SceneManager.clearSceneDict()
	DungeonBuilder.increaseRooms()
	required_room = "-c n=" + str(DungeonBuilder.getRooms())
	var spawnPozione = "-c hp=" + str(round(vita))
	print(required_room, " ----- ", spawnPozione)
	DungeonBuilder.generateDungeon(builder, required_room, spawnPozione)
	DungeonBuilder.increasePiano()
	SceneManager.goto_scene("res://Scene/Gioco/Stanze/Room18.tscn", "null")
	
