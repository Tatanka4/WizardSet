extends Node

var dungeon
var col = 6
var row = 6
var dicRoom = {}
var piano = 1
var spawnPozioneHp = 0

var sceneRoom = {}

var rooms = 8

func _ready():
	randomize()
	initDic()

func generateDungeon(builder, required_room, hp = null):
	
	MainScript.setID(0)
	sceneRoom = {}
	
	print(required_room)
	var output = []
	
	var spawnPozione
	if hp == null:
		spawnPozione = "-c hp=3"
	else:
		spawnPozione = hp
	
	OS.execute("clingo.exe", [builder, "-n 1000", required_room, '--verbose=0', '--outf=2' ], true, output)
	output = JSON.parse(output[0]).result
	#print(output)
	var answerSet = []
	var size = len(output['Call'][0]['Witnesses'])
	#print(size)
	for i in range(0, size):
		var model = output['Call'][0]['Witnesses'][i]['Value']
		answerSet.append(model)
	
	var numeroAS = randi()%len(answerSet)
	var disposizioneScelta = answerSet[numeroAS]
	#print(numeroAS)
	#print(disposizioneScelta)
	
	dungeon = Utility.createArray2D(col, row)
	var coord = createArrayCoord(disposizioneScelta)
	var spawnVitaHp = getValueFromAsp(disposizioneScelta)
	
	var sceneToLoad
	
	for i in range (len(coord)):
		var x = int(coord[i][0])
		var y = int(coord[i][1])
		var val = int(coord[i][2])
		sceneToLoad = SceneManager.load_node("res://Scene/Gioco/Stanze/Room"+str(val)+".tscn")
		sceneRoom[sceneToLoad.getID()] = sceneToLoad
		#print(x, y, val)
		dungeon[x][y] = sceneToLoad.getID()
	
	Utility.printMatrix(dungeon)
	SceneManager.setSceneRoom(sceneRoom)
	

func createArrayCoord(answerSet):
	var regex = RegEx.new()
	var arrayCoord = []
	regex.compile("assign\\((\\d+),(\\d+),(\\d+)\\)")
	for i in range (len(answerSet)):
		var result = regex.search(answerSet[i])
		if result:
			var strings = result.get_strings()
			strings.pop_front()
			arrayCoord.append(strings)
			#print(strings)
	return arrayCoord

func getValueFromAsp(answerSet):
	var regex = RegEx.new()
	var value = 0
	regex.compile("spawnPozioneVita\\((\\d+)\\)")
	for i in range (len(answerSet)):
		var result = regex.search(answerSet[i])
		if result:
			var strings = result.get_strings()
			strings.pop_front()
			value = strings[0]
			print(value)
	spawnPozioneHp = value
	return spawnPozioneHp

func initDic():
	for i in range(1,19):
		var num = str(i)
		dicRoom[i] = "res://Scene/Gioco/Stanze/Room"+num+".tscn";
		
func nextRoom(numStanza, verso):
	print(numStanza)
	var x
	var y
	var trovato = false
	var roomNext
	for i in range(len(dungeon)):
		for j in range(len(dungeon[i])):
			if str(numStanza) == str(dungeon[i][j]):
				x = i
				y = j
				trovato = true
				#print(x," ",y," ",numStanza)
	if trovato:
		match verso:
			"nord":
				roomNext = dungeon[x - 1][y]
			"sud":
				roomNext = dungeon[x + 1][y]
			"est":
				roomNext = dungeon[x][y + 1]
			"ovest":
				roomNext = dungeon[x][y - 1]
	return roomNext
				

func setRooms(r):
	rooms = r

func getRooms():
	return rooms

func increaseRooms():
	if rooms < 16:
		rooms = rooms + 2
		
func getPiano():
	return piano

func increasePiano():
	piano += 1
	
func getSpawnPozione():
	return spawnPozioneHp

func getSceneRoom():
	return sceneRoom
