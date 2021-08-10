extends Control

func _ready():
	Manager.connect("s_nextLevel",self, "updatePersonaje")
	updatePersonaje()
	
func updatePersonaje():
	esconderPersonajes()
	# Esto es una proqueria se debe cambiar por algo mas modular
	if(Manager.nivelActual == 1):
		get_node("Contenedor/AtrasRandal").show()
		get_node("Contenedor/Randal").show()
	if(Manager.nivelActual == 2):
		get_node("Contenedor/Axolotl").show()
	if(Manager.nivelActual == 3):
		get_node("Contenedor/Juni").show()
	if(Manager.nivelActual == 4):
		get_node("Contenedor/Caiman").show()
#Esconde todos los personajes
func esconderPersonajes():
	get_node("Contenedor/AtrasRandal").hide()
	get_node("Contenedor/Randal").hide()
	get_node("Contenedor/Axolotl").hide()
	get_node("Contenedor/Juni").hide()
	get_node("Contenedor/Caiman").hide()
