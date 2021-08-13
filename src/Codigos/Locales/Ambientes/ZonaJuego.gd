extends Node

onready var tutorial_compartir = preload("res://Escenas/Habitats/Tutorial_Compartir.tscn")
onready var tutorial_eliminar = preload("res://Escenas/Habitats/Tutorial_Eliminar.tscn")
onready var tutorial_virus = preload("res://Escenas/Habitats/Tutorial_Virus.tscn")
onready var tutorial_terminos = preload("res://Escenas/Habitats/Tutorial_Terminos.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	#Manager.resetearNivel()
	$Transicion_juego_sale/espiral/AnimationPlayer.play("Crece")
	Manager.empaparruchometroActual = Manager.empaparruchometroInicial[Manager.nivelActual-1]	
	add_tuto()
	#Manager.figurasVerdaderas = []
	pass # Replace with function body.

func add_tuto():
	var nivel
	match Manager.nivelActual:
		1:			
			nivel = tutorial_compartir.instance()	
		2:			
			nivel = tutorial_eliminar.instance()	
		3:			
			nivel = tutorial_virus.instance()	
		4:			
			nivel = tutorial_terminos.instance()	
#	particula_instance.position = posicion_estrellitas.position	
#	particula_instance.emitting = true
	add_child_below_node($Opaco, nivel)
	
