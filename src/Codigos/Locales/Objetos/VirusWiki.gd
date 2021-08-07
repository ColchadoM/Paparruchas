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

func _ready():
	_entraVirus()
	#Conectar las signals
	Manager.connect("s_terminarNivel",self, "closeAnimation")
	
	var image = get_node("res://Recursos/Visuales/Sprites/ventana_virus.png")
	
	#Escalar random
#	var nScale = rand_range(1,3)
#	wikiV.scale = Vector2(nScale, nScale)

func _entraVirus():
	#print('entra')
	tween_inicio.interpolate_property(wikiV, 'scale', Vector2(0.01,0.01), Vector2(1.47,1.47),0.3, Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT)
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
	$Area2D.queue_free()
#		if wikiV.get_rect().has_point(to_local(event.position)) && !clickeadaV:
	Manager.emit_signal("s_virusTimer", position)
	clickeadaV=true
	clicMal.play()
	print('virus')
