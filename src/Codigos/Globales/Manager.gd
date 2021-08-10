extends Node

var medioIntro = preload("res://Escenas/Ambientes/Medio_intro.tscn")

enum EstadoJuego {INACTIVO, EN_JUEGO, JUEGO_PERDIDO, JUEGO_TERMINADO}
enum TipoDrop {NEUTRAL, BASURA, COMPARTIR} 
# Varialbes del juego
var estadoJuegoActual = EstadoJuego.INACTIVO
var enPausa:bool = false
var maxEmpaparruchamiento:Array = [15,25,25,35];
var minEmpaparruchamiento:int = 0;
var empaparruchometroInicial: Array = [10,20,20,30];
var empaparruchometroActual;
var figurasVerdaderas: Array = [] #{'tipo':valorFigura, 'objeto': figura}
var figuraAgarrada:bool = false;
# Niveles
var niveles = [1,2,3,4]
var nivelesDesbloqueados = [1]
var nivelActual = 1

#signals
signal s_empezarNivel
signal s_desempaparruchar(cantidad, lugar)
signal s_empaparruchar(cantidad, lugar)
signal s_terminarNivel(tipo)
signal s_afueraPantalla(x)
signal s_virusTimer(posicion)
signal entro_basura(tipo, ventana, posicion)
signal s_edroped(tipoVentana,area, posicion, lugar) #(lugar en donde entro la ventana) cuando un script drop se come una ventana
signal s_droped # cuando sueltas una ventana manualmente
signal s_terminoscondiciones
signal s_termina_terminos
signal s_paparruchometro_punto(punto, lugar)
signal s_nextLevel #pasar alsigueinte nivel

func _ready():
	pause_mode = PAUSE_MODE_PROCESS
	empaparruchometroActual = empaparruchometroInicial[nivelActual-1]
	#resetearNivel()

func _input(event):
	if event.is_action_pressed("Pausa"):
		if(get_tree().paused):
			pausar(true)
		else:
			pausar(false)

func pausar(vaAPausar:bool):
	if(vaAPausar):
		get_tree().get_root().get_node("ZonaJuego/Menus/Pausa").hide()
		get_tree().paused = false
	else:
		get_tree().get_root().get_node("ZonaJuego/Menus/Pausa").show()
		get_tree().paused = true

func siguienteNivel():
#	estadoJuegoActual = EstadoJuego.INACTIVO
	figurasVerdaderas = [] 
	empaparruchometroActual = empaparruchometroInicial[nivelActual-1]
#	get_tree().get_root().get_node("ZonaJuego/TextoInicio/TimerInicio").start()
	emit_signal("s_empezarNivel")
	if nivelesDesbloqueados.size() != 4:
		match nivelActual:
			1:
				if nivelesDesbloqueados.size() == 1:
					nivelesDesbloqueados = [1,2]
				else:
					pass
			2:
				if nivelesDesbloqueados.size() == 2:
					nivelesDesbloqueados = [1,2,3]
				else:
					pass
			3: 
				if nivelesDesbloqueados.size() == 3:
					nivelesDesbloqueados = [1,2,3,4]
				else:
					pass
			4:
				pass

	#if(nivelActual <= niveles.le)	
	#nivelActual += 1
	#nivelesDesbloqueados = [1,2]
	#resetearNivel()

func resetearNivel():
	estadoJuegoActual = EstadoJuego.INACTIVO
	figurasVerdaderas = [] 
	empaparruchometroActual = empaparruchometroInicial[nivelActual-1]
	get_tree().get_root().get_node("ZonaJuego/TextoInicio/TimerInicio").start()
	emit_signal("s_empezarNivel")

func _process(delta):
	if(estadoJuegoActual == EstadoJuego.EN_JUEGO):
		if(empaparruchometroActual <= minEmpaparruchamiento):
			estadoJuegoActual = EstadoJuego.JUEGO_TERMINADO
			get_tree().get_root().get_node("ZonaJuego/NivelExito").play()
			emit_signal("s_terminarNivel",0)
		elif(empaparruchometroActual >= maxEmpaparruchamiento[nivelActual-1]):
			estadoJuegoActual = EstadoJuego.JUEGO_PERDIDO
			get_tree().get_root().get_node("ZonaJuego/NivelPerdido").play()
			emit_signal("s_terminarNivel",1)
			yield(get_tree().create_timer(2.5),"timeout")
			get_tree().change_scene_to(medioIntro)

func empaparruchar(cantidad=1, lugar=''):
	Manager.empaparruchometroActual += cantidad
	emit_signal("s_desempaparruchar")
	emit_signal("s_paparruchometro_punto", 'malo', lugar)

func desempaparruchar(cantidad=1, lugar=''):
	Manager.empaparruchometroActual -= cantidad
	emit_signal("s_empaparruchar")
	emit_signal("s_paparruchometro_punto", 'bueno', lugar)
