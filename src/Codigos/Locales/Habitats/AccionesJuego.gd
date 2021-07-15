extends Control

onready var seleccion = $Seleccion
onready var eliminar = $Eliminar
onready var compartir = $Compartir

func _input(event):
	if event.is_action_pressed("Change"):
		Manager.eliminandoNoticias = !Manager.eliminandoNoticias
		if(Manager.eliminandoNoticias):
			seleccion.rect_position = Vector2(eliminar.rect_position.x-60,eliminar.rect_position.y-40)
		else:
			seleccion.rect_position = Vector2(compartir.rect_position.x-90,compartir.rect_position.y-90)
			
	if event is InputEventMouseButton && event.pressed && event.button_index == BUTTON_LEFT:
		if eliminar.get_rect().has_point(event.position):
			Manager.eliminandoNoticias = true;
			seleccion.rect_position = Vector2(eliminar.rect_position.x-60,eliminar.rect_position.y-40);
		if compartir.get_rect().has_point(event.position):
			Manager.eliminandoNoticias = false;
			seleccion.rect_position = Vector2(compartir.rect_position.x-90,compartir.rect_position.y-90)
