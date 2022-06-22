extends Node

var objDic = {}

func _ready():
	initDic()
	pass

func createArray2D(x,y):

	var arrayFinal = []
	for i in range(x):
		var array = []
		for j in range(y):
			array.append("X")
		arrayFinal.append(array)

	return arrayFinal


func printMatrix(matrix):
	print("*****************")
	for i in range(len(matrix)):
		#print(i)
		print(matrix[i])
		pass
	print("*****************")
	

###TRESAURES UTILTY###

func initDic():
	objDic[0] = "res://Entità/Pozioni/Pozione_HP.tscn";
	objDic[1] = "res://Entità/Pozioni/Pozione_Speed.tscn";
	objDic[2] = "res://Entità/Pozioni/Pozione_SpSh.tscn";
	objDic[3] = "res://Entità/Pergamene/Pergamena_Fuoco.tscn";

func getObj(index):
	if objDic.has(index):
		return objDic[index]
	else:
		return null

#################
