extends Node

enum EstadoJuego {INACTIVO, EN_JUEGO, JUEGO_PERDIDO, JUEGO_TERMINADO}
# Varialbes del juego
var estadoJuegoActual = EstadoJuego.INACTIVO
var enPausa:bool = false
var maxEmpaparruchamiento:int = 20;
var minEmpaparruchamiento:int = 0;
var empaparruchometroInicial: int = 10;
var empaparruchometroActual: int = 10;
var figurasVerdaderas: Array = [] #{'tipo':valorFigura, 'objeto': figura}
var eliminandoNoticias: bool = true # si es false esta compartiendo

#signals
signal s_empezarNivel
signal s_desempaparruchar
signal s_empaparruchar
signal s_terminarNivel(tipo)
signal s_afueraPantalla(x)

func _ready():
	pause_mode = PAUSE_MODE_PROCESS
	if estadoJuegoActual == EstadoJuego.EN_JUEGO:
		resetearNivel()

func _input(event):
	if event.is_action_pressed("Pausa"):
		if(get_tree().paused):
			get_tree().get_root().get_node("ZonaJuego/Pausa").hide()
			get_tree().paused = false
		else:
			get_tree().get_root().get_node("ZonaJuego/Pausa").show()
			get_tree().paused = true

func resetearNivel():
	estadoJuegoActual = EstadoJuego.INACTIVO
	empaparruchometroActual = empaparruchometroInicial
	get_tree().get_root().get_node("ZonaJuego/TextoInicio/TimerInicio").start()
	emit_signal("s_empezarNivel")

func _process(delta):
	if(estadoJuegoActual == EstadoJuego.EN_JUEGO):
		if(empaparruchometroActual <= minEmpaparruchamiento):
			estadoJuegoActual = EstadoJuego.JUEGO_TERMINADO
			get_tree().get_root().get_node("ZonaJuego/NivelExito").play()
			emit_signal("s_terminarNivel",0)
		elif(empaparruchometroActual >= maxEmpaparruchamiento):
			estadoJuegoActual = EstadoJuego.JUEGO_PERDIDO
			get_tree().get_root().get_node("ZonaJuego/NivelPerdido").play()
			emit_signal("s_terminarNivel",1)

func empaparruchar(cantidad=1):
	Manager.empaparruchometroActual += cantidad
	emit_signal("s_desempaparruchar")
	#print(Manager.empaparruchometroActual)

func desempaparruchar(cantidad=1):
	Manager.empaparruchometroActual -= cantidad
	emit_signal("s_empaparruchar")
	#print(Manager.empaparruchometroActual)
