extends Particles2D


func _ready():
	#Senales.connect("cambia_paparruchometro", self, 'start')
	start()
	#yield(get_tree().create_timer(0.1),"timeout")
	#self.emitting = true
	#one_shot = true
#	Senales.connect("cambia_paparruchometro", self, '_crea_particulas')
	pass

#func _crea_particulas(puntos):
#	if puntos > 0:
#

func start():
	print('dedejdie')
	emitting = true

#func _on_Timer_timeout():
#	print('sacas')
#	queue_free()
#	pass # Replace with function body.
