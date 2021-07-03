extends Node2D

onready var e1 = $E1
onready var e2 = $E2

var empaparruchado: bool;
var velEmpaparruchado: float = 2

func _ready():
	pass # Replace with function body.

func _process(delta):
	e1.rotate(delta * velEmpaparruchado)
	e2.rotate(delta * velEmpaparruchado)
