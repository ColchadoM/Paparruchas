extends Sprite

enum EstadoVentana {IDLE, ARRASTRANDO, REGRESANDO, ECESTADA}

onready var area_ventana = $Area2D 
onready var area_virus = $Area_virus
onready var audioClick = $AudioClick
onready var clicBien = $ClicBien
onready var clicMal = $ClicMal
onready var tweenClose = $TweenClose
onready var figura = $Figura

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
	Manager.connect("s_edroped",self,'colisionDrop')
	Manager.connect("s_terminoscondiciones", self, "tiempo_lento")
	
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
			if(Helpers.estanCerca(position, posicion_ultima,35)):
				estadoVentana = EstadoVentana.IDLE
				Manager.figuraAgarrada = false
		elif estadoVentana == EstadoVentana.ECESTADA:
			position = lerp(position, posicion_drop, 25 * delta)
			if(Helpers.estanCerca(position, posicion_ultima,5)):
				deleteada = true
		else:
			position.y += speed * delta
			rotation = lerp_angle(rotation, 0, 10 * delta)
			# Revisa si se salio de la pantalla
			if(position.y > get_viewport().size.y + texture.get_height()):
				deleteada=true
				#Revisa si es una paparrucha
				if(!Helpers.esNoticiaVerdadera(Manager.figurasVerdaderas, valorFigura)):
					Manager.emit_signal("s_afueraPantalla", position.x)
					clicMal.play()
				closeAnimation()

# Si se tiene una ventana agarrada y despues se suelta
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.pressed and estadoVentana == EstadoVentana.ARRASTRANDO:
			estadoVentana = EstadoVentana.REGRESANDO

# Si el mouse esta dentro del area de la ventana y esta es agarrada
func _on_Area2D_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("Toca") && estadoVentana == EstadoVentana.IDLE && !Manager.figuraAgarrada:
		audioClick.play() 
		posicion_ultima = position
		estadoVentana = EstadoVentana.ARRASTRANDO
		area_virus.set_collision_layer_bit(1, true)
		print(area_virus.get_collision_layer_bit(2))
		Manager.figuraAgarrada = true

# Si un drop se come una ventana
func colisionDrop(tipo, area, posicion):
	if(estadoVentana != EstadoVentana.ARRASTRANDO):
		area_virus.set_collision_layer_bit(1, false)
		return
	posicion_drop = posicion
	if area == area_ventana:
		area_virus.set_collision_layer_bit(1, false)
		estadoVentana = EstadoVentana.ECESTADA
		area_ventana.queue_free()
		Manager.emit_signal("s_droped") # si el proceso de comerse un ventana acaba
		
		if(tipo == Manager.TipoDrop.BASURA):
			if !Helpers.esNoticiaVerdadera(Manager.figurasVerdaderas, valorFigura):
				clicBien.play()
				Manager.desempaparruchar()
			else:
				clicMal.play()
				Manager.empaparruchar()
		elif(tipo == Manager.TipoDrop.COMPARTIR):
			if Helpers.esNoticiaVerdadera(Manager.figurasVerdaderas, valorFigura):
				clicBien.play()
				Manager.desempaparruchar()
			else:
				clicMal.play()
				Manager.empaparruchar()
		else:
			pass
			
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


func _on_TweenClose_tween_completed(object, key):
	queue_free()
