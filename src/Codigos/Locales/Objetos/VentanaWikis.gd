extends RigidBody2D

onready var colision = $CollisionShape2D
onready var sprite = $Sprite
onready var audioClick = $AudioClick
onready var clicBien = $ClicBien
onready var clicMal = $ClicMal
onready var tween = $Tween
var valorFigura: int = -1
var clickeada: bool = false

export var speed: float = 180;

func _input(event):
	if event is InputEventMouseButton && event.pressed && event.button_index == BUTTON_LEFT:
		if sprite.get_rect().has_point(to_local(event.position)) && !clickeada:
			clickeada=true
			audioClick.play()
			if(Helpers.existFigura(Manager.figurasVerdaderas, valorFigura)):
				if(Manager.eliminandoNoticias):
					Manager.empaparruchar()
					clicMal.play()
				else:
					Manager.desempaparruchar()
					clicBien.play()
			else:
				if(Manager.eliminandoNoticias):
					Manager.desempaparruchar()
					clicBien.play()
				else:
					Manager.empaparruchar()
					clicMal.play()
			closeAnimation()


func _ready():
	#Conectar las signals
	Manager.connect("s_terminarNivel",self, "closeAnimation")
	
	var figures_data = {
	Constants.FIGURA.Triangulo: load("res://Codigos/Locales/Objetos/Triangulo.tres"),
	Constants.FIGURA.Cuadro: load("res://Codigos/Locales/Objetos/Cuadro.tres"),
	Constants.FIGURA.Estrella: load("res://Codigos/Locales/Objetos/Estrella.tres")
	}
	var image = get_node("Sprite/Figura")
	var rng = RandomNumberGenerator.new()
	rng.randomize();
	valorFigura = rng.randi_range(0,Constants.FIGURA.size() -1)
	image.texture = figures_data[valorFigura].image
	#Escalar random
	var nScale = rand_range(1.2,2)
	sprite.scale = Vector2(nScale, nScale)


func _physics_process(delta):
	position.y += speed * delta
	if(position.y > get_viewport().size.y + get_node("Sprite").texture.get_height()):
		Manager.emit_signal("s_afueraPantalla", position.x)
		Manager.empaparruchar()
		clicMal.play()
		queue_free()
		

func closeAnimation():
	tween.interpolate_property(sprite, "scale",
		sprite.scale, Vector2(0, 0), 0.5,
		Tween.TRANS_BACK , Tween.EASE_IN)
	tween.start()


func _on_Tween_tween_completed(object, key):
	queue_free()
