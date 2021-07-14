extends Node

enum EstadoJuego {INACTIVO, EN_JUEGO, JUEGO_TERMINADO}
# Varialbes del juego
var estadoJuegoActual = EstadoJuego.INACTIVO
var enPausa:bool = false
var empaparruchometro: int = 30;
var figurasVerdaderas: Array = [] #{'tipo':valorFigura, 'objeto': figura}
var eliminandoNoticias: bool = true # si es false esta compartiendo

#signals
signal s_desempaparruchar
signal s_empaparruchar

func _ready():
	pause_mode = PAUSE_MODE_PROCESS

func _input(event):
	if event.is_action_pressed("Pausa"):
		get_tree().paused = !get_tree().paused

func empaparruchar(cantidad=1):
	Manager.empaparruchometro += cantidad
	emit_signal("s_desempaparruchar")
	#print(Manager.empaparruchometro)

func desempaparruchar(cantidad=1):
	Manager.empaparruchometro -= cantidad
	emit_signal("s_empaparruchar")
	#print(Manager.empaparruchometro)

func _on_Manager_s_empaparruchar():
	pass # Replace with function body.
