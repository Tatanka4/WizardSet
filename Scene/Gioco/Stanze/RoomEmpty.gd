extends Node2D

var matrixRoom
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	print("NUOVO")
	matrixRoom = Utility.createNumeratedArray2D(6, 12)
	if(MainScript.getDebug()): Utility.printMatrix(matrixRoom)
	self.populate(RoomBuilder.generateRoom())
	

func populate(model):
	var rocciaScene = preload("res://Entità/Altro/Roccia.tscn")
	var trapScene = preload("res://Entità/Meccanismi/SpuntoniS.tscn")
	var potionSpeedScene = preload("res://Entità/Pozioni/Pozione_Speed.tscn")
	var potionHPScene = preload("res://Entità/Pozioni/Pozione_HP.tscn")
	var potionSpShScene = preload("res://Entità/Pozioni/Pozione_SpSh.tscn")
	
	var doorNord = preload("res://Scene/Gioco/Entrate/EntrataNord.tscn")
	var doorEst = preload("res://Scene/Gioco/Entrate/EntrataEst.tscn")
	var doorOvest = preload("res://Scene/Gioco/Entrate/EntrataOvest.tscn")
	var doorSud = preload("res://Scene/Gioco/Entrate/EntrataSud.tscn")

	var nodeRocce = splitObjects(model)
	var nodeTrap = splitTrap(model)
	var nodePower = splitPower(model)
	var nodeDoor = splitDoors(model)
	
	var tilemap = get_child(0)
	
	var floor_cells = tilemap.get_used_cells_by_id(1)
	if(MainScript.getDebug()): print(floor_cells)
	
	var coordCellsRocce = fillArrayWithCells(nodeRocce)
	
	for i in range(len(coordCellsRocce)):
		var index = floor_cells.find(coordCellsRocce[i])
		var rocciaInstance = rocciaScene.instance()
		var realCoord = tilemap.map_to_world(floor_cells[index])
		if(MainScript.getDebug()): print(realCoord)
		rocciaInstance.position = realCoord + Vector2(16,16) #OFFSET
		tilemap.add_child(rocciaInstance)
		
	var coordCellsTrap = fillArrayWithCells(nodeTrap)
	
	for i in range(len(coordCellsTrap)):
		var index = floor_cells.find(coordCellsTrap[i])
		var trapInstance = trapScene.instance()
		var realCoord = tilemap.map_to_world(floor_cells[index])
		if(MainScript.getDebug()): print(realCoord)
		trapInstance.position = realCoord + Vector2(16,16) #OFFSET
		trapInstance.scale = trapInstance.scale - Vector2(1,1)
		print(trapInstance.scale)
		tilemap.add_child(trapInstance)
		
	var coordCellsPower = fillArrayWithCells(nodePower)
	
	for i in range(len(coordCellsPower)):
		var index = floor_cells.find(coordCellsPower[i])
		var powerInstance
		rng.randomize()
		var n = rng.randi_range(1, 3)
		if n == 1:
			powerInstance = potionHPScene.instance()
		elif n == 2:
			powerInstance = potionSpeedScene.instance()
		else:
			powerInstance = potionSpShScene.instance()
		var realCoord = tilemap.map_to_world(floor_cells[index])
		if(MainScript.getDebug()): print(realCoord)
		powerInstance.position = realCoord + Vector2(16,16) #OFFSET
		#trapInstance.scale = trapInstance.scale - Vector2(1,1)
		print(powerInstance.scale)
		tilemap.add_child(powerInstance)
	
	var coordCellsDoor = fillArrayWithCells(nodeDoor)
	var sides = []
	
	for i in range(len(coordCellsDoor)):
		var actualCell = coordCellsDoor[i]
		if (actualCell == Vector2(7,2) or actualCell == Vector2(8,2)): #Nord
			tilemap.set_cell(actualCell[0], actualCell[1] - 1, 1)
			sides.append("N")
		elif (actualCell == Vector2(2,4) or actualCell == Vector2(2,5)): #Oves
			tilemap.set_cell(actualCell[0] - 1, actualCell[1], 1)
			sides.append("O")
		elif (actualCell == Vector2(13,4) or actualCell == Vector2(13,5)): #Est
			tilemap.set_cell(actualCell[0] + 1, actualCell[1], 1)
			sides.append("E")
		else: #Sud
			tilemap.set_cell(actualCell[0], actualCell[1] + 1, 1)
			sides.append("S")
	
	
	for s in (len(sides) / 2):
		var doorInstance = null
		if(sides[s] == "N"):
			doorInstance = doorNord.instance()
			tilemap.add_child(doorInstance)
			doorInstance.position = Vector2(254.311, 25.919)
		if(sides[s] == "O"):
			doorInstance = doorOvest.instance()
			tilemap.add_child(doorInstance)
			doorInstance.position = Vector2(24.794, 160.299)
		if(sides[s] == "E"):
			doorInstance = doorEst.instance()
			tilemap.add_child(doorInstance)
			doorInstance.position = Vector2(487.99, 159.11)
		else:
			doorInstance = doorSud.instance()
			tilemap.add_child(doorInstance)
			doorInstance.position = Vector2(253.682, 293.713)
	
func splitObjects(model):
	var regex = RegEx.new()
	regex.compile("object\\(\\d+\\)")
	
	var rocceArray = []
	for i in range (len(model)):
		var result = regex.search(str(model[i]))
		if result:
			var strings = result.get_strings()
			rocceArray.append(int(strings[0]))
	if(MainScript.getDebug()): print(rocceArray)
	return rocceArray

func splitDoors(model):
	var regex = RegEx.new()
	regex.compile("door\\(\\d+\\)")
	
	var doorArray = []
	
	for i in range (len(model)):
		var result = regex.search(str(model[i]))
		if result:
			var strings = result.get_strings()
			doorArray.append(int(strings[0]))
	if(MainScript.getDebug()): print(doorArray)
	return doorArray
	
func splitTrap(model):
	var regex = RegEx.new()
	regex.compile("trap\\(\\d+\\)")
	
	var trapArray = []
	
	for i in range (len(model)):
		var result = regex.search(str(model[i]))
		if result:
			var strings = result.get_strings()
			trapArray.append(int(strings[0]))
	if(MainScript.getDebug()): print(trapArray)
	return trapArray

func splitPower(model):
	var regex = RegEx.new()
	regex.compile("powerUp\\(\\d+\\)")
	
	var powerArray = []
	
	for i in range (len(model)):
		var result = regex.search(str(model[i]))
		if result:
			var strings = result.get_strings()
			powerArray.append(int(strings[0]))
	if(MainScript.getDebug()): print(powerArray)
	return powerArray

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_T:
			get_tree().change_scene("res://Scene/Gioco/Stanze/RoomEmpty.tscn")

func fillArrayWithCells(array):
	var finalArray = []
	for i in range (len(array)):
		var x = -1
		var y = -1
		for j in (len(matrixRoom)):
			for k in (len(matrixRoom[j])):
				if int(matrixRoom[j][k]) == int(array[i]):
					x = j
					y = k
					finalArray.append(Vector2(y+2,x+2)) #+2 perchè le celle iniziano da 2,2 che equivale a 0,0
					break
	return finalArray
