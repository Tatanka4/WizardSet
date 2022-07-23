extends Label

var builder = "DungeonBuilder/RoomBuilder.cl"
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func generateRoom():
	
	rng.randomize()
	
	var nDoors = [2,4,6,8]
	
	var boundObj = "-c boundObjects=" + str(rng.randi_range(0, 40))
	var boundTrap = "-c boundTraps=" + str(rng.randi_range(0, 10))
	var boundPower = "-c boundPU=" + str(rng.randi_range(0, 2))
	var boundDoors = "-c nDoors=" + str(nDoors[rng.randi_range(0, 3)])
	
	var output = []
	OS.execute("clingo.exe", [builder, boundObj, boundTrap, boundPower, boundDoors,
	 "-n 1000", '--verbose=0', '--outf=2' ], true, output)
	
	output = JSON.parse(output[0]).result
	#if(MainScript.getDebug()): print(output)

	var answerSet = []
	var size = len(output['Call'][0]['Witnesses'])
	if(MainScript.getDebug()): print(size)
	for i in range(0, size):
		var model = output['Call'][0]['Witnesses'][i]['Value']
		answerSet.append(model)
	
	var numeroAS = randi()%len(answerSet)
	var disposizioneScelta = answerSet[numeroAS]
	if(MainScript.getDebug()): print(numeroAS)
	if(MainScript.getDebug()): print(disposizioneScelta)
	
	return disposizioneScelta
