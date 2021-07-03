extends NinePatchRect

#Imports
onready var figurasPaquete = preload("res://Escenas/Objetos/Figura.tscn")

export var figurasIniciales = 2
export var figurasMax = 3
#var figuras: Array = []
var cambiando = false;

func _ready():
	inicializarFiguras()

# Añadir figura (si llega al maximo, elimina la primer figura)
func inicializarFiguras():
	for i in figurasIniciales:
		var pos = 110*i + 50
		agregarFigura(false,pos)

func _input(event):
	if event.is_action_pressed("Delete"):
		quitarFigura()
	if event.is_action_pressed("Add"):
		agregarFigura()
		
#Agregar una figura		
func agregarFigura(animacion=true, newPosX=null):
	if(Manager.figurasVerdaderas.size() >= Constants.FIGURA.size() || Manager.figurasVerdaderas.size() >= figurasMax):
		print("maximo figuras alcanzado");
		return
	
	var figura = figurasPaquete.instance();
	var rng = RandomNumberGenerator.new()
	rng.randomize();
	var valorFigura = rng.randi_range(0,Constants.FIGURA.size() -1)
	while(Helpers.existFigura(Manager.figurasVerdaderas,valorFigura)):
		valorFigura = rng.randi_range(0,Constants.FIGURA.size() -1)
	figura.tipo = valorFigura; # cambiar imágen

	var posX = 110*Manager.figurasVerdaderas.size() + 50
	if(newPosX):
		posX = newPosX
	figura.rect_position = Vector2(posX, figura.rect_position.y);
	add_child(figura);
	Manager.figurasVerdaderas.push_back({'tipo':valorFigura, 'objeto': figura})
	#Agregar animacion
	if(animacion):
		var tween = figura.get_node("Tween")
		tween.interpolate_property(figura, "rect_scale",
			Vector2(0,0), Vector2(1, 1), 0.4,
			Tween.TRANS_EXPO, Tween.EASE_IN)
		tween.start()
	
# Quitar la primer figura
func quitarFigura():
	if (Manager.figurasVerdaderas.size() <= 0): 
		return
	
	var tween = Manager.figurasVerdaderas[0].objeto.get_node("Tween")
	tween.interpolate_property(Manager.figurasVerdaderas[0].objeto, "rect_scale",
		Vector2(1,1), Vector2(0, 0), 0.4,
		Tween.TRANS_BACK , Tween.EASE_IN)
	tween.start()
	yield(tween, "tween_completed")
	
	Manager.figurasVerdaderas[0].objeto.queue_free()
	Manager.figurasVerdaderas.pop_front();
	
	recorrerFiguras()
	
func recorrerFiguras():
	for f in Manager.figurasVerdaderas:
		var tween = f.objeto.get_node("Tween");
		var actualPos = f.objeto.rect_position;
		tween.interpolate_property(f.objeto, "rect_position",
			Vector2(actualPos.x, actualPos.y), Vector2(actualPos.x -110, actualPos.y), 0.2,
			Tween.TRANS_LINEAR  , Tween.EASE_IN)
		tween.start();
