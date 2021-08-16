extends Control

onready var inicio_esc = preload("res://Escenas/Ambientes/Introduccion_chapulin.tscn")
onready var menu_niveles = preload("res://Escenas/Ambientes/Menu_Niveles.tscn")
onready var jugar_btn = $HSeparator/CenterContainer/Jugar

func _ready():
	$negro/Tween_negro.interpolate_property($negro, 'color', Color(0,0,0,1), Color(0,0,0,0), 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	yield(get_tree().create_timer(0.1), "timeout")
	$negro/Tween_negro.start()
	pass
	




func _on_Jugar_pressed():
	$Bg/Tween.interpolate_property($Bg, 'volume_db', 0, -50, 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Bg/Tween.start()
	$vidrio_arriba.show()
	$vidrio_izquierda.show()
	$vidrio_abajo.show()
	$vidrio_derecha.show()
	$blanco.show()
	
	$blanco/Tween.interpolate_property($blanco, 'color', Color('6effffff'), Color('ffffff'), 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$blanco/Tween.start()
	
	yield(get_tree().create_timer(1), "timeout")
	$vidrio_arriba/Tween.interpolate_property($vidrio_arriba, 'rect_position', Vector2($vidrio_arriba.rect_position.x, $vidrio_arriba.rect_position.y),
	Vector2($vidrio_arriba.rect_position.x, $vidrio_arriba.rect_position.y - $vidrio_arriba.rect_size.y), 2.5, Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
	$vidrio_arriba/Tween.start()
	
	$vidrio_izquierda/Tween.interpolate_property($vidrio_izquierda, 'rect_position', Vector2($vidrio_izquierda.rect_position.x, $vidrio_izquierda.rect_position.y),
	Vector2($vidrio_izquierda.rect_position.x - $vidrio_izquierda.rect_size.x, $vidrio_izquierda.rect_position.y), 2.5, Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
	$vidrio_izquierda/Tween.start()
	
	$vidrio_abajo/Tween.interpolate_property($vidrio_abajo, 'rect_position', Vector2($vidrio_abajo.rect_position.x, $vidrio_abajo.rect_position.y),
	Vector2($vidrio_abajo.rect_position.x, $vidrio_abajo.rect_position.y + $vidrio_abajo.rect_size.y), 2.5, Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
	$vidrio_abajo/Tween.start()
	
	$vidrio_derecha/Tween.interpolate_property($vidrio_derecha, 'rect_position', Vector2($vidrio_derecha.rect_position.x, $vidrio_derecha.rect_position.y),
	Vector2($vidrio_derecha.rect_position.x + $vidrio_derecha.rect_size.x, $vidrio_derecha.rect_position.y), 2.5, Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
	$vidrio_derecha/Tween.start()
	
	
	yield(get_tree().create_timer(1.5), "timeout")
	Manager.nivelActual = 1
	if Manager.nivelesDesbloqueados.size() > 1:		
		get_tree().change_scene_to(menu_niveles)
	else:	
		get_tree().change_scene_to(inicio_esc)
	


func _on_gnu_licencia_toggled(button_pressed):
	print(button_pressed)
	if button_pressed:
#		print('ddsads')
		$ventana_terminos/Tween.interpolate_property($ventana_terminos, 'rect_scale', Vector2(0,0), Vector2(0.618,0.618), 1, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
		$ventana_terminos/Tween.start()
		pass # Replace with function body.
	else:
#		print('ddsads')
		$ventana_terminos/Tween.interpolate_property($ventana_terminos, 'rect_scale', Vector2(0.618,0.618), Vector2(0,0), 1, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
		$ventana_terminos/Tween.start()
		pass # Replace with function body.
