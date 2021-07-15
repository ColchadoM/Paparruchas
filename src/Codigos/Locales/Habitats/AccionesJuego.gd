extends Control

onready var seleccion = $Seleccion
onready var eliminar = $Eliminar
onready var compartir = $Compartir

func _input(event):
	if event.is_action_pressed("Change"):
		Manager.eliminandoNoticias = !Manager.eliminandoNoticias
		if(Manager.eliminandoNoticias):
			seleccion.rect_position = Vector2(compartir.rect_position.x-90,compartir.rect_position.y-90)
		else:
			seleccion.rect_position = Vector2(eliminar.rect_position.x-60,eliminar.rect_position.y-40)
	
	

