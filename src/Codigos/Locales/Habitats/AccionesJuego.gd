extends Control

onready var seleccion = $Seleccion
onready var eliminar = $Eliminar
onready var compartir = $Compartir


func _input(event):
	if event.is_action_pressed("Change"):
		print("holaaaa")
		Manager.eliminandoNoticias = !Manager.eliminandoNoticias
		
		if(Manager.eliminandoNoticias):
			seleccion.rect_position.y = 719
		else:
			seleccion.rect_position.y = 513

