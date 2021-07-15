extends Control

export(Translation) var texto
export(Texture) var fondo
var textos_array = []
var texto_escena = 1
var texto_parte = 1
export(String) var texto_key
var texto_formato = "%s_%s_%s"
var texto_tamano = 1
var clic_num = 1
var clicable = true
var tamano_pantalla
var entra_escena = 0

var fondo_texto = preload("res://Recursos/Visuales/Interfaz/contenedor_texto.png")
var fondo_texto_2 = preload("res://Recursos/Visuales/Interfaz/contenedor_texto_2.png")

export(Resource) var siguiente_escena
#var siguiente_escena = preload(siguiente_escena_string)
#export(NodePath) var siguiente_escena = preload(siguiente_escena)

onready var tween_p_1 = $Contenedor_1/Personaje_1/Tween
onready var personaje_1 = $Contenedor_1/Personaje_1
onready var tween_p_2 = $Contenedor_2/Personaje_2/Tween
onready var personaje_2 = $Contenedor_2/Personaje_2
onready var contenedor_1 = $Contenedor_1
onready var contenedor_2 = $Contenedor_2
onready var horizontal_t_2 = $Contenedor_2/Tween
onready var horizontal_t_1 = $Contenedor_1/Tween

func _ready():
	tamano_pantalla = get_viewport().size
	print(tamano_pantalla)
	#contenedor_2.rect_position.x = -(contenedor_2.rect_size.x)
	$Fondo.texture = fondo
	for key in texto.get_message_list():
		var orden_texto = key.split_floats('_')
		orden_texto.remove(0)
		textos_array.append(orden_texto)
		tween_p_1.interpolate_property(personaje_1, 'rect_scale', Vector2(1, 1), Vector2(1.2, 1.2), 0.5,Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)	
		tween_p_1.start() 
#rect_scale = Vector2(1.2, 1.2)
	
	
	
	TranslationServer.set_locale("es")
	
	$Contenedor_texto/Texto.bbcode_text = tr(texto_formato % [texto_key, texto_escena, texto_parte])
	pass # Replace with function body.




func _on_Boton_siguiente_pressed():
	if clicable:	
		clicable = false	
		clic_num = (clic_num + 1)%2
		
		
		
		if texto_tamano != textos_array.size() && clic_num == 0:		
			if entra_escena == 5:
				texto_parte = texto_parte + 1
				avanza_escena(texto_parte, textos_array, texto_escena)
				descubre_texto()
				clicable = true
				entra_escena += 1
				
				var distancia_left = 30
	#			tween_p_2.interpolate_property(personaje_2, 'rect_scale', Vector2(1, 1), Vector2(1.2, 1.2), 1.5,Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
				tween_p_2.interpolate_property(contenedor_2, 'rect_position', Vector2(contenedor_2.rect_position.x, contenedor_2.rect_position.y), 
				Vector2( distancia_left, 
				contenedor_2.rect_position.y), 1.5, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
				
				tween_p_2.start()
				
			else:
				texto_parte = texto_parte + 1
				avanza_escena(texto_parte, textos_array, texto_escena)
				descubre_texto()
				clicable = true
				entra_escena += 1
			
			
		elif clic_num == 1:
			$Contenedor_texto/Texto.percent_visible = 1
			$Contenedor_texto/Texto.bbcode_text = texto_formato % [texto_key, texto_escena, texto_parte]
			$Contenedor_texto/Texto.bbcode_text = tr(texto_formato % [texto_key ,texto_escena, texto_parte])
			clicable = true
		elif texto_tamano == textos_array.size():
			get_tree().change_scene_to(siguiente_escena)
	

func avanza_escena(parte, textos, escena):
	var alguno = 0
	texto_tamano = texto_tamano + 1
	for texto in textos:
		if texto[0] == escena:
			if texto[1] == parte:
				alguno = alguno + 1

	if alguno == 0:
		texto_parte = 1
		texto_escena = texto_escena + 1
		var textura_num = texto_escena % 2
		print(texto_escena)
		
		if textura_num == 0:
			if texto_escena == 2:
				var distancia_left = 30
			
				tween_p_2.interpolate_property(personaje_2, 'rect_scale', Vector2(1, 1), Vector2(1.2, 1.2), 0.5,Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
				tween_p_1.interpolate_property(personaje_1, 'rect_scale', Vector2(1.2, 1.2), Vector2(1, 1), 0.5,Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
				tween_p_1.interpolate_property(contenedor_1, 'rect_position', Vector2(contenedor_1.rect_position.x, contenedor_1.rect_position.y), 
				Vector2(tamano_pantalla.x - contenedor_1.rect_size.x - distancia_left, 
				contenedor_1.rect_position.y), 1.5, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
				tween_p_1.start() 
				tween_p_2.start()
				$Contenedor_fondo_texto/Fondo_texto.texture = fondo_texto_2
				
			else:
				tween_p_2.interpolate_property(personaje_2, 'rect_scale', Vector2(1, 1), Vector2(1.2, 1.2), 0.5,Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
				tween_p_1.interpolate_property(personaje_1, 'rect_scale', Vector2(1.2, 1.2), Vector2(1, 1), 0.5,Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
				tween_p_2.start()
				tween_p_1.start() 
				$Contenedor_fondo_texto/Fondo_texto.texture = fondo_texto_2

				
		else:
			tween_p_2.interpolate_property(personaje_2, 'rect_scale', Vector2(1.2, 1.2), Vector2(1, 1), 0.5,Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
			tween_p_1.interpolate_property(personaje_1, 'rect_scale', Vector2(1, 1), Vector2(1.2, 1.2), 0.5,Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
			
			tween_p_2.start()
			tween_p_1.start()
			$Contenedor_fondo_texto/Fondo_texto.texture = fondo_texto
			
		
		
	
	
func descubre_texto():
	
	$Contenedor_texto/Texto.percent_visible = 0
	$Contenedor_texto/Texto.bbcode_text = texto_formato % [texto_key, texto_escena, texto_parte]
	$Contenedor_texto/Texto.bbcode_text = tr(texto_formato % [texto_key, texto_escena, texto_parte])
	
	for i in range(100):
		if clic_num == 1:
			pass
		else:
			$Contenedor_texto/Texto.percent_visible = $Contenedor_texto/Texto.percent_visible + 0.01		
			yield(get_tree().create_timer(0.01),"timeout")
	
	$Contenedor_texto/Texto.percent_visible = 1
	clic_num = 1
	
	
	
