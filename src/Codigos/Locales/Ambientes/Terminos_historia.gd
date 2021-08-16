extends Control


func _ready():
	TranslationServer.set_locale("es")
	$DialogNode.connect("dialogic_signal", self, 'dialogic_signal')
	$ColorRect/Tween.interpolate_property($ColorRect, 'color', Color('ffffff'), Color('00ffffff'), 2.5, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	$ColorRect/Tween.start()

func dialogic_signal(argument):
	match argument:		
		"termina":
			$Bg/Tween.interpolate_property($Bg, 'volume_db', 0, -50, 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Bg/Tween.start()			
			Manager.nivelActual = 4
			Manager.figurasVerdaderas = []
			Manager.empaparruchometroActual = Manager.empaparruchometroInicial[Manager.nivelActual-1]
			$Transicion_juego_crece.inicia_transicion()
		"terminos_aceptar":
			$terminos_aceptar/Tween.interpolate_property($terminos_aceptar, 'rect_scale', Vector2(0,0), Vector2(1,1), 0.4, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
			$terminos_aceptar/Tween.start()
		"terminos_aceptar_termina":
			$terminos_aceptar/Tween.interpolate_property($terminos_aceptar, 'rect_scale', Vector2(1,1), Vector2(0,0), 0.4, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
			$terminos_aceptar/Tween.start()
		"fade_negro":
			$ColorRectNegro/Tween.interpolate_property($ColorRectNegro, 'color', Color('00000000'), Color('000000'), 0.6, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
			$ColorRectNegro/Tween.start()
			yield(get_tree().create_timer(0.8),"timeout")			
			$ColorRectNegro/Tween.interpolate_property($ColorRectNegro, 'color', Color('000000'), Color('00000000'), 0.6, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
			$ColorRectNegro/Tween.start()
