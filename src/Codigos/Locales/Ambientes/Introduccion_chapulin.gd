extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	TranslationServer.set_locale("es")
	$DialogNode.connect("dialogic_signal", self, 'dialogic_signal')
	$ColorRect/Tween.interpolate_property($ColorRect, 'color', Color('ffffff'), Color('00ffffff'), 2.5, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	$ColorRect/Tween.start()
	#$Transicion_juego.inicia_transicion()
	pass # Replace with function body.

func dialogic_signal(argument):
	match argument:
		'falsa':	
			$ventana_gris/Tween.interpolate_property($ventana_gris, 'rect_scale', Vector2(0,0), Vector2(1,1), 0.4, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
			$ventana_gris/Tween.start()
		'real':
			$figuras_txt/Tween.interpolate_property($figuras_txt, 'rect_position', Vector2(766,-400), Vector2(766,40), 0.4, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
			$figuras_txt/Tween.start()
			$ventana_gris/Tween.interpolate_property($ventana_gris, 'rect_scale', Vector2(1,1), Vector2(0.6,0.6), 0.4, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
			$ventana_gris/Tween.start()
		"termina":
			$Transicion_juego_crece.inicia_transicion()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
