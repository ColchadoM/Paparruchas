extends Control

func _ready():
	Manager.connect("s_terminarNivel",self,"mostarMenu")
	
	
# 1 Pierde - 0 Gana
func mostarMenu(tipo):
	yield(get_tree().create_timer(2),"timeout")
	if(tipo == 0):
		get_node("GameOver").show()
		var tween = get_node("TweenInicio")
		tween.interpolate_property(get_node("GameOver"), "modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 1), 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.start()
	else:
		get_node("GameEnd").show()
		var tween = get_node("TweenInicio")
		tween.interpolate_property(get_node("GameEnd"), "modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 1), 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.start()

func esconderMenu():
	get_node("GameOver").hide()
	get_node("GameEnd").hide()

func _on_Reiniciar_pressed():
	esconderMenu()
	Manager.resetearNivel()

func _on_Siguiente_pressed():
	Manager.siguienteNivel()
	Manager.emit_signal("s_nextLevel")
	esconderMenu()

func _on_Continuar_pressed():
	print("pressed")


func _on_Salir_pressed():
	print("salir")
	pass # Replace with function body.
