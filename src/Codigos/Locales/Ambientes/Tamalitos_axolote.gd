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
			Manager.nivelActual = 2
			Manager.figurasVerdaderas = []
			Manager.empaparruchometroActual = Manager.empaparruchometroInicial[Manager.nivelActual-1]
			$Transicion_juego_crece.inicia_transicion()
