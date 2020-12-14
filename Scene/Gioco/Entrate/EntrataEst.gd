extends StaticBody2D

var player

func _ready():
	set_process(false)
	
func entra(animazione):
	if animazione == "Cammina_Dx":
		var nextRoomPath = DungeonBuilder.nextRoom(get_parent().get_parent().name, "est")
		#print(nextRoomPath)
		SceneManager.goto_scene(nextRoomPath, "ovest") #poi aggiustare con mappe random
		#print(get_parent().get_parent().name)
