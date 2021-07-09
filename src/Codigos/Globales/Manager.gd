extends Node

# Varialbes del juego
var empaparruchometro: int = 30;
var figurasVerdaderas: Array = [] #{'tipo':valorFigura, 'objeto': figura}
var eliminandoNoticias: bool = true # si es false esta compartiendo

func empaparruchar(cantidad=1):
	Manager.empaparruchometro += cantidad
	#print(Manager.empaparruchometro)

func desempaparruchar(cantidad=1):
	Manager.empaparruchometro -= cantidad
	#print(Manager.empaparruchometro)


func _on_Manager_s_empaparruchar():
	pass # Replace with function body.
