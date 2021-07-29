extends Sprite

onready var audioClick = $AudioClick
onready var clicBien = $ClicBien
onready var clicMal = $ClicMal
onready var tween = $Tween
onready var figura = $Figura
var valorFigura: int = -1
var clickeada: bool = false
var deleteada: bool = false

export var speed: float = 180;

func _input(event):
	if event is InputEventMouseButton && event.is_pressed() && event.button_index == BUTTON_LEFT:
		if get_rect().has_point(to_local(event.position)) && !clickeada:
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
	Constants.FIGURA.Estrella: load("res://Codigos/Locales/Objetos/Estrella.tres"),
	Constants.FIGURA.CircM: load("res://Codigos/Locales/Objetos/CircM.tres")
	}
	var rng = RandomNumberGenerator.new()
	rng.randomize();
	valorFigura = rng.randi_range(0,Constants.FIGURA.size() -1)
	figura.texture = figures_data[valorFigura].image
	#Escalar random
	var nScale = rand_range(1.8,2.8)
	scale = Vector2(nScale, nScale)


func _physics_process(delta):
	if(!deleteada):
		position.y += speed * delta
		if(position.y > get_viewport().size.y + texture.get_height()):
			deleteada = true;
			Manager.emit_signal("s_afueraPantalla", position.x)
			Manager.empaparruchar()
			clicMal.play()
			closeAnimation()
		

func closeAnimation(tipo=0):
	tween.interpolate_property(self, "scale",
		scale, Vector2(0, 0), 0.5,
		Tween.TRANS_BACK , Tween.EASE_IN)
	tween.start()


func _on_Tween_tween_completed(object, key):
	queue_free()

