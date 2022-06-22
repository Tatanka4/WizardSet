extends StaticBody2D

var player

func _ready():
	set_process(false)
	
func entra(animazione):
	if animazione == "Cammina_Sx":
		var nextRoomPath = DungeonBuilder.nextRoom(get_parent().get_parent().getID(), "ovest")
		#print(nextRoomPath)
		SceneManager.goto_scene(int(nextRoomPath), "est") #poi aggiustare con mappe random
		#print(get_parent().get_parent().name)
