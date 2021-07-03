extends Node

func existFigura(array, value):
	for a in array:
		if a.tipo == value:
			return true
	return false
