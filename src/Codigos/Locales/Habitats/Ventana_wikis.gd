extends RigidBody2D

onready var colision = $CollisionShape2D
onready var sprite = $Sprite
export var speed: float = 40;

var dentro = false
var opcion = 0

func _ready():
	var nScale = rand_range(0.4,1)
	colision.scale = Vector2(nScale,nScale)
	sprite.scale = Vector2(nScale + 0.43, nScale + 0.43)

func _physics_process(delta):
	position.y += speed * delta



