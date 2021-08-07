extends Control

onready var niveles = $CenterContainer/Grid_Niveles
onready var juego_1 = preload("res://Escenas/Ambientes/ZonaJuego.tscn")

func _ready():
	for nivel in range(niveles.get_child_count()):
		Manager.niveles.append(nivel+1)
	
	for nivel in niveles.get_children():
		if str2var(nivel.name) in range(Manager.nivelesDesbloqueados+1):
			nivel.disabled = false
			nivel.connect('pressed', self, 'level_button_pressed',
							[nivel.name]) # Connect the signal of all enabled buttons with an extra variable attached
		else:
			nivel.disabled = true #Disable all unlocked level buttons
	


func level_button_pressed(escena:Object):
	#print('hsdsuh')
	yield(get_tree().create_timer(2),"timeout")
	get_tree().change_scene_to(escena) # Change scene to any selected level



func _on_1_pressed():
	$Transicion_juego_crece.inicia_transicion()
	
	level_button_pressed(juego_1)
