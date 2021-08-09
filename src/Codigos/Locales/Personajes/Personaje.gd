extends Node2D

var empaparruchado: bool;
var velEmpaparruchado: float = 2

func _ready():
	Manager.connect("s_desempaparruchar",self, "actualizar")
	Manager.connect("s_empaparruchar",self, "actualizar")
	Manager.connect("s_empezarNivel",self, "actualizar")

func _process(delta):
	get_node("Empaparruchado/Randal01").rotate(delta * velEmpaparruchado)
	get_node("Empaparruchado/Randal02").rotate(delta * velEmpaparruchado)
	
func actualizar():
	if(Manager.empaparruchometroActual >= Manager.maxEmpaparruchamiento[Manager.nivelActual-1]-1):
		get_node("Bruma").show()
		var tween = get_node("Tween")
		tween.interpolate_property(get_node("Bruma"), "scale",
			0, 1, 10, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
	else:
		get_node("Bruma").hide()
