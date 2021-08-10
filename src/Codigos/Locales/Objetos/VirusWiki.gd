extends Node2D

onready var colision = $CollisionShape2D
onready var wikiV = $WikiV
onready var audioClick = $AudioClick
onready var clicBien = $ClicBien
onready var clicMal = $ClicMal
onready var tween = $Tween
onready var tween_inicio = $Tween_inicio
var clickeadaV: bool = false
var deleteadaV: bool = false
var speedV: float = 300
var apenas_creada = true

var virus_p = preload("res://Escenas/Objetos/virus_particula.tscn")


func _ready():
	_entraVirus()
	
	#Conectar las signals
	Manager.connect("s_terminarNivel",self, "closeAnimation")
	
	var image = get_node("res://Recursos/Visuales/Sprites/ventana_virus.png")
	yield(get_tree().create_timer(0.5), "timeout")
	apenas_creada = false	
	#Escalar random
#	var nScale = rand_range(1,3)
#	wikiV.scale = Vector2(nScale, nScale)

func _entraVirus():
	#print('entra')
	tween_inicio.interpolate_property(wikiV, 'scale', Vector2(0,0), Vector2(0.18,0.18),0.3, Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT)
	tween_inicio.start()

func _physics_process(delta):
	if(!deleteadaV):
		position.y += speedV * delta
		#print(speedV * delta)
		if(position.y > get_viewport().size.y + get_node("WikiV").texture.get_height()):
			deleteadaV = true;
			closeAnimation()
		

func closeAnimation(tipo=0):
	tween.interpolate_property(wikiV, "scale",
		wikiV.scale, Vector2(0, 0), 0.5,
		Tween.TRANS_BACK , Tween.EASE_IN)
	tween.start()


func _on_Tween_tween_completed(object, key):
	queue_free()


func _on_Area2D_input_event(viewport, event, shape_idx):
	pass
#	if Input.is_action_just_pressed("Toca"):
#		$Area2D.queue_free()
##		if wikiV.get_rect().has_point(to_local(event.position)) && !clickeadaV:
#		Manager.emit_signal("s_virusTimer", position)
#		clickeadaV=true
#		clicMal.play()
		#closeAnimation()


func _on_Area2D_area_entered(area):
	if !apenas_creada:
		$Area2D.queue_free()
		particula_creada_v()
	#		if wikiV.get_rect().has_point(to_local(event.position)) && !clickeadaV:
		Manager.emit_signal("s_virusTimer", position)
		clickeadaV=true
		clicMal.play()
		print('virus')
	
func particula_creada_v():
	print("particles")
	var particula_instance = virus_p.instance()
#	particula_instance.position = posicion_estrellitas.position
	particula_instance.emitting = true
	add_child(particula_instance)
