extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	#Manager.resetearNivel()
	$Transicion_juego_sale/espiral/AnimationPlayer.play("Crece")
	Manager.empaparruchometroActual = Manager.empaparruchometroInicial[Manager.nivelActual-1]
	#Manager.figurasVerdaderas = []
	pass # Replace with function body.
