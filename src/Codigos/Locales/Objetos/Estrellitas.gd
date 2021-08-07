extends Particles2D


func _ready():
	Manager.connect("entro_basura", self, 'start')
	#Senales.connect("cambia_paparruchometro", self, 'start')
	#start()
	#yield(get_tree().create_timer(0.1),"timeout")
	#self.emitting = true
	#one_shot = true
#	Senales.connect("cambia_paparruchometro", self, '_crea_particulas')
	

func start(tipo, ventana, posicion):
	#print('ADSADASDSA')
	#emitting = true
	pass
