extends Node2D

func init(entrata):
	match entrata:
		"sud":
			$Wizard.global_position = $TileMap/EntrataSud.global_position
			$Wizard.get_node("Wizard").play("Cammina_Up_Dx")
		"nord":
			$Wizard.global_position = $TileMap/EntrataSud.global_position
			$Wizard.get_node("Wizard").play("Cammina_Dx")
		"est":
			$Wizard.global_position = $TileMap/EntrataSud.global_position
			$Wizard.get_node("Wizard").play("Cammina_Dx")
		"ovest":
			$Wizard.global_position = $TileMap/EntrataSud.global_position
			$Wizard.get_node("Wizard").play("Cammina_Sx")
