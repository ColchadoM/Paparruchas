extends RigidBody2D

onready var colision = $CollisionShape2D
onready var sprite = $Sprite
onready var audioClick = $AudioClick
onready var tween = $Tween
export var speed: float = 180;

func _ready():
	var figures_data = {
	Constants.FIGURA.Triangulo: load("res://Codigos/Locales/Objetos/Triangulo.tres"),
	Constants.FIGURA.Cuadro: load("res://Codigos/Locales/Objetos/Cuadro.tres"),
	Constants.FIGURA.Estrella: load("res://Codigos/Locales/Objetos/Estrella.tres")
	}
	var image = get_node("Sprite/Figura")
	image.texture = figures_data[int(rand_range(0,3))].image
	#Escalar random
	var nScale = rand_range(0.5,1.2)
	colision.scale = Vector2(nScale,nScale)
	sprite.scale = Vector2(nScale + 0.43, nScale + 0.43)

func _physics_process(delta):
	position.y += speed * delta
	if(position.y > get_viewport().size.y + get_node("Sprite").texture.get_height()):
		queue_free()

func _input(event):
	if event is InputEventMouseButton && event.pressed && event.button_index == BUTTON_LEFT:
		if sprite.get_rect().has_point(to_local(event.position)):
			audioClick.play()
			closeAnimation()
			
func closeAnimation():
	tween.interpolate_property(sprite, "scale",
		sprite.scale, Vector2(0, 0), 0.5,
		Tween.TRANS_BACK , Tween.EASE_IN)
	tween.start()


func _on_Tween_tween_completed(object, key):
	queue_free()
