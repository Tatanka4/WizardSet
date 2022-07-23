extends Node

var debug = false
var countID = 0

func increaseID():
	countID += 1

func getID():
	return countID

func setID(value):
	countID = value

func getDebug():
	return debug
	
func setDebug(mode):
	debug = mode


