extends StaticBody2D

var player

func _ready():
	set_process(false)
	
func entra(animazione):
	if animazione == "Cammina_Up_Dx":
		var nextRoomPath = DungeonBuilder.nextRoom(get_parent().get_parent().name, "nord")
		#print(nextRoomPath)
		SceneManager.goto_scene(nextRoomPath, "sud") #poi aggiustare con mappe random
		#print(get_parent().get_parent().name)
