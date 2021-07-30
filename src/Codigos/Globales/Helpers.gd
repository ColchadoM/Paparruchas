extends Node

#Funcion que compara si existe una figura en un arreglo
func esNoticiaVerdadera(array, value):
	for a in array:
		if a.tipo == value:
			return true
	return false

# Funcion que compapra si dos posiciones(Vector2) estan cerca
func estanCerca(vectorF, vectorS, desviacion):
	var cercaX:bool = false;
	var cercaY:bool = false;
	
	if abs(vectorF.x - vectorS.x) < desviacion:
		cercaX=true
	
	if abs(vectorF.y - vectorS.y) < desviacion:
		cercaY=true
		
	if cercaX && cercaY:
		return true
	return false
