extends Control

onready var inicio = preload("res://Escenas/Ambientes/Medio_intro.tscn")

func _ready():
	TranslationServer.set_locale("es")
	$DialogNode.connect("dialogic_signal", self, 'dialogic_signal')
	$ColorRect/Tween.interpolate_property($ColorRect, 'color', Color('ffffff'), Color('00ffffff'), 2.5, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	$ColorRect/Tween.start()

func dialogic_signal(argument):
	match argument:		
		"termina":
			$clic_foto.play()
			yield(get_tree().create_timer(0.2), "timeout")
			$ColorRect/Tween.interpolate_property($ColorRect, 'color', Color('00ffffff'), Color('ffffff'), 0.2, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
			$ColorRect/Tween.start()			
			yield(get_tree().create_timer(0.2), "timeout")
			$Foto.visible = true
			$Foto_bg.visible = true
			yield(get_tree().create_timer(0.6), "timeout")
			$Creditos/AnimationPlayer.play("creditos")
			$ColorRect/Tween.interpolate_property($ColorRect, 'color', Color('ffffff'), Color('00ffffff'), 2.5, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
			$ColorRect/Tween.start()			
			Manager.nivelActual = 1
			Manager.figurasVerdaderas = []
			Manager.empaparruchometroActual = Manager.empaparruchometroInicial[Manager.nivelActual-1]
			#$Transicion_juego_crece.inicia_transicion()
		"fade_negro":
			$ColorRectNegro/Tween.interpolate_property($ColorRectNegro, 'color', Color('00000000'), Color('000000'), 0.6, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
			$ColorRectNegro/Tween.start()
			yield(get_tree().create_timer(0.8),"timeout")			
			$ColorRectNegro/Tween.interpolate_property($ColorRectNegro, 'color', Color('000000'), Color('00000000'), 0.6, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
			$ColorRectNegro/Tween.start()


func _on_AnimationPlayer_animation_finished(anim_name):
	yield(get_tree().create_timer(2), "timeout")
	$ColorRect/Tween.interpolate_property($ColorRect, 'color', Color('00ffffff'), Color('ffffff'), 3, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	$ColorRect/Tween.start()
	$Bg/Tween.interpolate_property($Bg, 'volume_db', 0, -50, 3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Bg/Tween.start()			
	yield(get_tree().create_timer(3), "timeout")
	get_tree().change_scene_to(inicio)
