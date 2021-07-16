extends Control

func _ready():
	get_node("Listo").rect_scale = Vector2(0,0)
	get_node("Adelante").rect_scale = Vector2(0,0)

func _on_TimerInicio_timeout():
	var tweenListo = get_node("TweenListo")
	tweenListo.interpolate_property(get_node("Listo"), "rect_scale",
			Vector2(0, 0), Vector2(1, 1), 0.4,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tweenListo.start()


func _on_TweenListo_tween_all_completed():
	get_node("TimerAdelante").start()


func _on_TimerAdelante_timeout():
	var tweenListo = get_node("Listo").hide()
	var tweenAdelante = get_node("TweenAdelante")
	tweenAdelante.interpolate_property(get_node("Adelante"), "rect_scale",
			Vector2(0, 0), Vector2(1, 1), 0.4,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tweenAdelante.start()

func _on_TweenAdelante_tween_all_completed():
	get_node("TimerFinal").start()
	
func _on_TimerFinal_timeout():
	var tweenListo = get_node("Adelante").hide()




