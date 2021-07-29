extends Sprite

enum EstadoVentana {IDLE, ARRASTRANDO, REGRESANDO}

onready var area_ventana = $Area2D 
onready var audioClick = $AudioClick
onready var clicBien = $ClicBien
onready var clicMal = $ClicMal
onready var tweenClose = $TweenClose
onready var figura = $Figura

var tipo_ventana = 'paparrucha'
var valorFigura: int = -1
var estadoVentana = EstadoVentana.IDLE
var deleteada:bool = false

var posicion_drop:Vector2
var posicion_ultima:Vector2
var speed:float = 180

export var puntaje = 5

func _ready():
	#Conectar las signals
	Manager.connect("s_terminarNivel",self, "closeAnimation")
	Manager.connect("entro_basura",self,'soltoDrop')
	
	# Escala y figuras diferentes
	var figures_data = {
	Constants.FIGURA.Triangulo: load("res://Codigos/Locales/Objetos/Triangulo.tres"),
	Constants.FIGURA.Cuadro: load("res://Codigos/Locales/Objetos/Cuadro.tres"),
	Constants.FIGURA.Estrella: load("res://Codigos/Locales/Objetos/Estrella.tres"),
	Constants.FIGURA.CircM: load("res://Codigos/Locales/Objetos/CircM.tres")
	}
	var rng = RandomNumberGenerator.new()
	rng.randomize();
	valorFigura = rng.randi_range(0,Constants.FIGURA.size() -1)
	figura.texture = figures_data[valorFigura].image
	#Escalar random
	var nScale = rand_range(1.2,2)
	scale = Vector2(nScale, nScale)
	

func _physics_process(delta):
	if(!deleteada):
		if estadoVentana == EstadoVentana.ARRASTRANDO:
			position = lerp(position, get_global_mouse_position(), 25 * delta)
			#look_at(get_global_mouse_position())
		elif estadoVentana == EstadoVentana.REGRESANDO:
			position = lerp(position, posicion_ultima, 5 * delta)
			if(estanCerca(position, posicion_ultima,35)):
				estadoVentana = EstadoVentana.IDLE
				Manager.figuraAgarrada = false
		else:
			position.y += speed * delta
			rotation = lerp_angle(rotation, 0, 10 * delta)
	else:
		position = lerp(position, posicion_drop, 25 * delta)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.pressed and estadoVentana == EstadoVentana.ARRASTRANDO:
			estadoVentana = EstadoVentana.REGRESANDO

func _on_Area2D_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("Toca") && estadoVentana == EstadoVentana.IDLE && !Manager.figuraAgarrada: 
		posicion_ultima = position
		estadoVentana = EstadoVentana.ARRASTRANDO
		Manager.figuraAgarrada = true

func soltoDrop(tipo, area, posicion):
	posicion_drop = posicion
	if area == area_ventana:
		deleteada=true
		area_ventana.queue_free()
		if tipo_ventana == tipo:
			Manager.emit_signal("_droped", puntaje)
		else:
			Manager.emit_signal("_droped", -puntaje)
		desaparce()

func desaparce():
	Manager.figuraAgarrada = false
	$Tween.interpolate_property(self, 'scale', self.scale, Vector2(0,0), 0.4, Tween.TRANS_SINE, Tween.EASE_OUT)
	$Tween.start()
	yield(get_tree().create_timer(0.5), "timeout")
	queue_free()
	
func closeAnimation(tipo=0):
	tweenClose.interpolate_property(self, "scale",
		scale, Vector2(0, 0), 0.5,
		Tween.TRANS_BACK , Tween.EASE_IN)
	tweenClose.start()


func estanCerca(vectorF, vectorS, desviacion):
	var cercaX:bool = false;
	var cercaY:bool = false;
	
	if abs(vectorF.x - vectorS.x) < desviacion:
		cercaX=true
	
	if abs(vectorF.y - vectorS.y) < desviacion:
		cercaY=true
		
	if cercaX && cercaY:
		return true
	return false


func _on_TweenClose_tween_completed(object, key):
	queue_free()
