extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var empaparruchado = preload("res://Escenas/Habitats/Empaparruchado.tscn")
export var num_paparruchas = 5
var lista_pa = []

# Called when the node enters the scene tree for the first time.
func _ready():	
	aparece_em(num_paparruchas)
	


func aparece_em(n):
	var y_posi = 0
	for i in range(n):
		var empaparr = empaparruchado.instance()
		empaparr.position = Vector2(rand_range(30,700),-(y_posi+(i*200)))				
		$".".add_child(empaparr)
		lista_pa.append(empaparr)
		

func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		var empaparr = empaparruchado.instance()
		empaparr.position = Vector2(rand_range(30,700),-200)
		$".".add_child(empaparr)
		lista_pa.append(empaparr)
		
	if Input.is_action_just_pressed("ui_left"):
		$".".remove_child(lista_pa[0])
		lista_pa.remove(0)
		if lista_pa.size() == 0:
			print('ganaste')

