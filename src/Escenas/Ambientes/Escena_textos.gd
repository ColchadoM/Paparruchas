extends Control

export(Translation) var texto
var textos_array = []
var texto_escena = 1
var texto_parte = 1
var texto_formato = "INTRO_%s_%s"
var texto_tamano = 1
var clic_num = 1
var clicable = true

var fondo_texto = preload("res://Recursos/Visuales/Interfaz/contenedor_texto.png")
var fondo_texto_2 = preload("res://Recursos/Visuales/Interfaz/contenedor_texto_2.png")

func _ready():
	for key in texto.get_message_list():
		var orden_texto = key.split_floats('_')
		orden_texto.remove(0)
		textos_array.append(orden_texto)


	TranslationServer.set_locale("es")
	
	$Contenedor_texto/Texto.bbcode_text = tr(texto_formato % [texto_escena, texto_parte])
	pass # Replace with function body.




func _on_Boton_siguiente_pressed():
	if clicable:	
		clicable = false	
		clic_num = (clic_num + 1)%2
		if texto_tamano != textos_array.size() && clic_num == 0:		
			texto_parte = texto_parte + 1
			avanza_escena(texto_parte, textos_array, texto_escena)
			descubre_texto()
			clicable = true
		elif clic_num == 1:
			$Contenedor_texto/Texto.percent_visible = 1
			$Contenedor_texto/Texto.bbcode_text = texto_formato % [texto_escena, texto_parte]
			$Contenedor_texto/Texto.bbcode_text = tr(texto_formato % [texto_escena, texto_parte])
			clicable = true
	

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
		print(textura_num)
		if textura_num == 0:
			$Contenedor_personajes/Contenedor_1/Personaje_1.rect_scale = Vector2(1.2,1.2)
			$Contenedor_personajes/Contenedor_2/Personaje_2.rect_scale = Vector2(0.7,0.7)
			$Contenedor_fondo_texto/Fondo_texto.texture = fondo_texto_2
		else:
			$Contenedor_personajes/Contenedor_2/Personaje_2.rect_scale = Vector2(1.2, 1.2)
			$Contenedor_personajes/Contenedor_1/Personaje_1.rect_scale = Vector2(0.7,0.7)
			$Contenedor_fondo_texto/Fondo_texto.texture = fondo_texto
	
	
func descubre_texto():
	
	$Contenedor_texto/Texto.percent_visible = 0
	$Contenedor_texto/Texto.bbcode_text = texto_formato % [texto_escena, texto_parte]
	$Contenedor_texto/Texto.bbcode_text = tr(texto_formato % [texto_escena, texto_parte])
	
	for i in range(100):
		if clic_num == 1:
			pass
		else:
			$Contenedor_texto/Texto.percent_visible = $Contenedor_texto/Texto.percent_visible + 0.01		
			yield(get_tree().create_timer(0.01),"timeout")
	
	$Contenedor_texto/Texto.percent_visible = 1
	clic_num = 1
	
	
	
