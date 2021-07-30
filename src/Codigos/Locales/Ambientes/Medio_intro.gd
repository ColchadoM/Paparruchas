extends Control

var escena_intro = preload("res://Escenas/Ambientes/Intro_Paparruchas.tscn")

func _ready():
	$negro/Tween.interpolate_property($negro, 'color', Color(0,0,0,0), Color(0,0,0,1), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	pass


func _on_Timer_timeout():
	$negro/Tween.start()
	yield(get_tree().create_timer(0.6), "timeout")
	get_tree().change_scene_to(escena_intro)
	
	pass # Replace with function body.
