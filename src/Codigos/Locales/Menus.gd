extends Control

func _ready():
	Manager.connect("s_terminarNivel",self,"mostarMenu")
	
# 1 Pierde - 0 Gana
func mostarMenu(tipo):
	yield(get_tree().create_timer(2),"timeout")
	if(tipo == 0):
		get_node("GameOver").show()
		var tween = get_node("TweenInicio")
		tween.interpolate_property(get_node("GameOver"), "modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 1), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.start()
	else:
		get_node("GameOver").show()
		var tween = get_node("TweenInicio")
		tween.interpolate_property(get_node("GameOver"), "modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 1), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.start()


func _on_Button_pressed():
	var nextScene = load("res://Escenas/Ambientes/Intro_Paparruchas.tscn")
	get_tree().change_scene_to(nextScene)

func _on_Reiniciar_pressed():
	get_node("GameOver").hide()
	Manager.resetearNivel()
