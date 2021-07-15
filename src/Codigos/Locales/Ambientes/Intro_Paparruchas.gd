extends Control

onready var inicio_esc = preload('res://Escenas/Ambientes/Intro_historia.tscn')
onready var jugar_btn = $HSeparator/CenterContainer/Jugar

func _ready():
	pass
	




func _on_Jugar_pressed():
	get_tree().change_scene_to(inicio_esc)
