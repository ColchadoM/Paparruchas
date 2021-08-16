extends Control

onready var niveles = $CenterContainer/Grid_Niveles
#onready var juego_1 = preload("res://Escenas/Ambientes/ZonaJuego.tscn")

onready var texto_1 = preload("res://Escenas/Ambientes/Introduccion_chapulin.tscn")
onready var texto_2 = preload("res://Escenas/Ambientes/Tamalitos_axolote.tscn")
onready var texto_3 = preload("res://Escenas/Ambientes/Virus_juni.tscn")
onready var texto_4 = preload("res://Escenas/Ambientes/Terminos_historia.tscn")

export(Array, NodePath) var niveles_paths
var niveles_array:Array
var textos_escenas:Array

func _ready():
	textos_escenas = [texto_1, texto_2, texto_3, texto_4]
	
	for path in niveles_paths:
		var nodo = get_node(path)
		niveles_array.append(nodo)		
		
	for nivel in range(niveles_array.size()):
		Manager.niveles.append(nivel+1)
	
	for nivel in niveles_array:
		if str2var(nivel.name) in range(Manager.nivelesDesbloqueados.size()+1):
			nivel.disabled = false
			nivel.connect('pressed', self, 'level_button_pressed', [str2var(nivel.name)]) # Connect the signal of all enabled buttons with an extra variable attached
		else:
			nivel.disabled = true #Disable all unlocked level buttons
	


func level_button_pressed(escena):	
	$Bg/Tween.interpolate_property($Bg, 'volume_db', 0, -50, 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Bg/Tween.start()
	Manager.nivelActual = escena	
	$Transicion_juego_crece.inicia_transicion()
	yield(get_tree().create_timer(2),"timeout")
	get_tree().change_scene_to(textos_escenas[escena-1]) # Change scene to any selected level


