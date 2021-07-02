extends NinePatchRect

#Imports
onready var figurasPaquete = preload("res://Escenas/Objetos/Figura.tscn")

export var figurasIniciales = 2
export var figurasMax = 3
var figuras: Array = []
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
	if(figuras.size() >= Constants.FIGURA.size() || figuras.size() >= figurasMax):
		print("maximo figuras alcanzado");
		return
	
	var figura = figurasPaquete.instance();
	var rng = RandomNumberGenerator.new()
	rng.randomize();
	var valorFigura = rng.randi_range(0,Constants.FIGURA.size() -1)
	while(existFigura(figuras,valorFigura)):
		valorFigura = rng.randi_range(0,Constants.FIGURA.size() -1)
	figura.tipo = valorFigura;

	var posX = 110*figuras.size() + 50
	if(newPosX):
		posX = newPosX
	figura.rect_position = Vector2(posX, figura.rect_position.y);
	add_child(figura);
	figuras.push_back({'tipo':valorFigura, 'objeto': figura})
	#Agregar animacion
	if(animacion):
		var tween = figura.get_node("Tween")
		tween.interpolate_property(figura, "rect_scale",
			Vector2(0,0), Vector2(1, 1), 0.4,
			Tween.TRANS_EXPO, Tween.EASE_IN)
		tween.start()
	
# Quitar la primer figura
func quitarFigura():
	if (figuras.size() <= 0): 
		return
	
	var tween = figuras[0].objeto.get_node("Tween")
	tween.interpolate_property(figuras[0].objeto, "rect_scale",
		Vector2(1,1), Vector2(0, 0), 0.4,
		Tween.TRANS_BACK , Tween.EASE_IN)
	tween.start()
	yield(tween, "tween_completed")
	
	figuras[0].objeto.queue_free()
	figuras.pop_front();
	
	recorrerFiguras()
	
func recorrerFiguras():
	for f in figuras:
		var tween = f.objeto.get_node("Tween");
		var actualPos = f.objeto.rect_position;
		tween.interpolate_property(f.objeto, "rect_position",
			Vector2(actualPos.x, actualPos.y), Vector2(actualPos.x -110, actualPos.y), 0.2,
			Tween.TRANS_LINEAR  , Tween.EASE_IN)
		tween.start();

func existFigura(array, value):
	for a in array:
		if a.tipo == value:
			return true
	return false
