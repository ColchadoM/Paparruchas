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
	if argument == "termina":
		$Transicion_juego_crece.inicia_transicion()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
