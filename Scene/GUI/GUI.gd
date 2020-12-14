extends CanvasLayer


# Declare member variables here. Examples:
var speed = 1
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	if  Input.is_action_just_pressed("ui_select"):
#		$"Velocità/Stat".text = str(a)
#		a = a + 1

func _on_Wizard_updateStats(speed, cooldown, vita, power):
	$"Velocità/Stat".text = str(speed)
	$"Cooldown/Stat".text = str(cooldown)
	$"Power/Stat".text = str(power)
	$"Piano/Stat".text = str(DungeonBuilder.getPiano())
	self._on_Wizard_updateHP(vita)
	
func _on_Wizard_infoRaccogliOggetto(info):
	match info:
		"oggetto":
			$"Informazione".text = "Premi SPAZIO per raccogliere l'oggetto"
		"scale":
			$"Informazione".text = "Premi SPAZIO per scendere di piano"


func _on_Wizard_rimuoviInfo():
	$"Informazione".text = ""


func _on_Wizard_updateHP(vita):
#New-System (3 vite)
	if vita <= 3:
		$"HP_System2/HP".play("6")
	if vita <= 2.5:
		$"HP_System2/HP".play("5")
	if vita <= 2:
		$"HP_System2/HP".play("4")
	if vita <= 1.5:
		$"HP_System2/HP".play("3")
	if vita <= 1:
		$"HP_System2/HP".play("2")
	if vita <= 0.5:
		$"HP_System2/HP".play("1")
	if vita <= 0:
		$"HP_System2/HP".play("0")



