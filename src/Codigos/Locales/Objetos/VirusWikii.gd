extends RigidBody2D

onready var colision = $CollisionShape2D
onready var wiki = $WikiV
onready var audioClick = $AudioClick
onready var clicBien = $ClicBien
onready var clicMal = $ClicMal
onready var tween = $Tween
var valorFigura: int = -1
var clickeada: bool = false
var deleteada: bool = false

export var speed: float = 180;

func _input(event):
	if event is InputEventMouseButton && event.pressed && event.button_index == BUTTON_LEFT:
		if wiki.get_rect().has_point(to_local(event.position)) && !clickeada:
			clickeada=true
			clicMal.play()
			closeAnimation()


func _ready():
	#Conectar las signals
	Manager.connect("s_terminarNivel",self, "closeAnimation")
	
	var image = get_node("res://Recursos/Visuales/Sprites/ventana_virus.png")
	#Escalar random
	var nScale = rand_range(1.8,2.8)
	wiki.scale = Vector2(nScale, nScale)


func _physics_process(delta):
	if(!deleteada):
		position.y += speed * delta
		if(position.y > get_viewport().size.y + get_node("WikiV").texture.get_height()):
			deleteada = true;
			Manager.emit_signal("s_afueraPantalla", position.x)
			Manager.empaparruchar()
			clicMal.play()
			closeAnimation()
		

func closeAnimation(tipo=0):
	tween.interpolate_property(wiki, "scale",
		wiki.scale, Vector2(0, 0), 0.5,
		Tween.TRANS_BACK , Tween.EASE_IN)
	tween.start()


func _on_Tween_tween_completed(object, key):
	queue_free()
