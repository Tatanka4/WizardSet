extends StaticBody2D

var player

var locked = false

func _ready():
	set_process(false)
	
func entra(animazione):
	if not locked:
		if animazione == "Cammina_Dx":
			var nextRoomPath = DungeonBuilder.nextRoom(get_parent().get_parent().name, "sud")
			#print(nextRoomPath)
			SceneManager.goto_scene(nextRoomPath, "nord") #poi aggiustare con mappe random
			#print(get_parent().get_parent().name)

func setLock(boolean):
	locked = boolean
