extends Node

enum EstadoJuego {INACTIVO, EN_JUEGO, JUEGO_PERDIDO, JUEGO_TERMINADO}
# Varialbes del juego
var estadoJuegoActual = EstadoJuego.INACTIVO
var enPausa:bool = false
var empaparruchometro: int = 10;
var figurasVerdaderas: Array = [] #{'tipo':valorFigura, 'objeto': figura}
var eliminandoNoticias: bool = true # si es false esta compartiendo

#signals
signal s_desempaparruchar
signal s_empaparruchar
signal s_terminarNivel

func _ready():
	pause_mode = PAUSE_MODE_PROCESS

func _input(event):
	if event.is_action_pressed("Pausa"):
		if(get_tree().paused):
			get_tree().get_root().get_node("ZonaJuego/Pausa").hide()
			get_tree().paused = false
		else:
			get_tree().get_root().get_node("ZonaJuego/Pausa").show()
			get_tree().paused = true

func _process(delta):
	if(estadoJuegoActual == EstadoJuego.EN_JUEGO):
		if(empaparruchometro <= 0):
			estadoJuegoActual = EstadoJuego.JUEGO_TERMINADO
			get_tree().get_root().get_node("ZonaJuego/GameOver").show()
			emit_signal("s_terminarNivel")
		elif(empaparruchometro >= 20):
			estadoJuegoActual = EstadoJuego.JUEGO_PERDIDO
			get_tree().get_root().get_node("ZonaJuego/GameOver").show()
			emit_signal("s_terminarNivel")

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
