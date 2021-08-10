extends Control

var particulas_virus = preload("res://Escenas/Objetos/error_particula.tscn")

func _ready():
	TranslationServer.set_locale("es")
	$DialogNode.connect("dialogic_signal", self, 'dialogic_signal')
	$ColorRect/Tween.interpolate_property($ColorRect, 'color', Color('ffffff'), Color('00ffffff'), 2.5, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	$ColorRect/Tween.start()

func dialogic_signal(argument):
	match argument:		
		"termina":
			Manager.nivelActual = 3
			Manager.figurasVerdaderas = []
			Manager.empaparruchometroActual = Manager.empaparruchometroInicial[Manager.nivelActual-1]
			$Transicion_juego_crece.inicia_transicion()
		"virus":
			particula_creada(particulas_virus)
			$ventana_virus/Tween.interpolate_property($ventana_virus, 'rect_scale', Vector2(0,0), Vector2(1,1), 0.4, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
			$ventana_virus/Tween.start()
		"fade_negro":
			$ColorRectNegro/Tween.interpolate_property($ColorRectNegro, 'color', Color('00000000'), Color('000000'), 0.6, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
			$ColorRectNegro/Tween.start()
			yield(get_tree().create_timer(0.8),"timeout")
			$ventana_virus/Tween.interpolate_property($ventana_virus, 'rect_scale', Vector2(1,1), Vector2(0,0), 0.1, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
			$ventana_virus/Tween.start()
			$ColorRectNegro/Tween.interpolate_property($ColorRectNegro, 'color', Color('000000'), Color('00000000'), 0.6, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
			$ColorRectNegro/Tween.start()
		"virus_grande":			
			$ventana_virus/Tween.interpolate_property($ventana_virus, 'rect_scale', Vector2(1,1), Vector2(1.6,1.6), 0.4, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
			$ventana_virus/Tween.start()
			yield(get_tree().create_timer(2.4),"timeout")
			$ventana_virus/Tween.interpolate_property($ventana_virus, 'rect_scale', Vector2(1.6,1.6), Vector2(1,1), 0.4, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
			$ventana_virus/Tween.start()

func particula_creada(tipo_particula):
	#print("particles")
	var particula_instance = tipo_particula.instance()	
	particula_instance.position = $ventana_virus.rect_position	
	particula_instance.emitting = true
	add_child(particula_instance)
