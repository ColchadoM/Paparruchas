extends Sprite

var minX: int = -130
var maxX: int = 130
var actualPaparruchas = 0

func _ready():
	get_node("Nob").position.x = -actualPaparruchas
	Manager.connect("s_desempaparruchar",self, "setPaparruchometro")
	Manager.connect("s_empaparruchar",self, "setPaparruchometro")
	Manager.connect("s_empezarNivel",self, "setPaparruchometro")
	
func porcentajeEmpaparruchado():
	return (Manager.empaparruchometroActual * 100)/(Manager.maxEmpaparruchamiento[Manager.nivelActual-1] - Manager.minEmpaparruchamiento)

func setPaparruchometro():
	var porcentaje:float = porcentajeEmpaparruchado() * 0.01
	print(porcentajeEmpaparruchado())
	var tamanioBarra = abs(minX) + abs(maxX)
	actualPaparruchas = maxX - (tamanioBarra * porcentaje)
	#get_node("Nob").position.x = -actualPaparruchas
	
	var tween = get_node("Tween")
	tween.interpolate_property(get_node("Nob"), "position",
			Vector2(get_node("Nob").position.x, get_node("Nob").position.y), Vector2(-actualPaparruchas, get_node("Nob").position.y), 0.2,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
