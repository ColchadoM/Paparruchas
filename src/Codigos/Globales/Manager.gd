extends Node

var estadoJuego = Constants.ESTADO_JUEGO.Jugando;

# Variables Zona de Juego
var empaparruchometro: int = 0;

func _ready():
	pass # Replace with function body.

func empaparruchar(cantidad=1):
	empaparruchometro += cantidad
