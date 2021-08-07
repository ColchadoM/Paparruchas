extends ColorRect


func _ready():
	Manager.connect("s_terminoscondiciones", self, "se_opaca")
	Manager.connect("s_termina_terminos", self, "se_desopaca")
	pass

func se_opaca():
	$Tween.interpolate_property(self, "color", Color(0,0,0,0), Color('99290521'), 0.2, Tween.TRANS_EXPO, Tween.EASE_OUT)
	$Tween.start()

func se_desopaca():
	$Tween.interpolate_property(self, "color", Color('99290521'), Color(0,0,0,0), 0.2, Tween.TRANS_EXPO, Tween.EASE_OUT)
	$Tween.start()
