extends Node2D

#Imports
onready var wikiPaquete = preload("res://Escenas/Objetos/VentanaWiki.tscn")
onready var wikiDrag = preload("res://Escenas/Objetos/Ventana_drag.tscn")
onready var wikiX = preload("res://Escenas/Objetos/WikiX.tscn")
onready var wikiVirus = preload("res://Escenas/Objetos/VirusWiki.tscn")
onready var wikiTerminos = preload("res://Escenas/Objetos/Ventana_terminos.tscn")
onready var screenWidth = get_viewport().size.x
onready var playzoneStart = screenWidth * Constants.playableArea

export var dragableWindows:bool = true
export var generando:bool = false

var castigo_virus:bool = false

func _ready():
	Manager.connect("s_afueraPantalla",self,"mmostarX")
	Manager.connect("s_virusTimer", self, "ClickVirus")
	Manager.connect("s_terminoscondiciones", self, 'terminoscondiciones')
	

func spawnWiki():
	var wiki
	if(dragableWindows):
		wiki = wikiDrag.instance()
	else:
		wiki = wikiPaquete.instance()
	var wikiH = wiki.get_node('Ventana_sprite').texture.get_height()
	var wikiW = wiki.get_node('Ventana_sprite').texture.get_width()
	wiki.position = Vector2(rand_range(playzoneStart + (wikiW/2),screenWidth -(wikiW/2)) , -(wikiH/2) - 50)
	add_child(wiki)

func spawnWikiVirus():
	var wikiVi = wikiVirus.instance()
	var wikiHV = wikiVi.get_node("WikiV").texture.get_height()
	var wikiWV = wikiVi.get_node("WikiV").texture.get_width()
	wikiVi.position = Vector2(rand_range(playzoneStart,screenWidth -(wikiWV/2)) , -(wikiHV/2) - 500)
	add_child(wikiVi)

func explotaVirus(posicion:Vector2):
	for i in range(10):
		var r_wiki_x = rand_range(-200,200)
		var r_wiki_y = rand_range(-200,200)-100
		var wikiVi = wikiVirus.instance()
		var wikiHV = wikiVi.get_node("WikiV").texture.get_height()
		var wikiWV = wikiVi.get_node("WikiV").texture.get_width()
		wikiVi.position = Vector2(posicion.x+(i*r_wiki_x),posicion.y+(i*r_wiki_y))
		add_child(wikiVi)
		yield(get_tree().create_timer(0.02),"timeout")
	
func spawnWikiTerminos():
	var wiki = wikiTerminos.instance()
	var wikiH = wiki.get_node("Area2D/sprite_terminos").texture.get_height()*wiki.get_node("Area2D/sprite_terminos").scale.y
	var wikiW = wiki.get_node("Area2D/sprite_terminos").texture.get_width()*wiki.get_node("Area2D/sprite_terminos").scale.x
	wiki.position = Vector2(rand_range(playzoneStart + (wikiW/2),screenWidth -(wikiW/2)) , -(wikiH/2) - 50)
	add_child(wiki)

func _on_Timer_timeout():
	if(Manager.estadoJuegoActual == Manager.EstadoJuego.EN_JUEGO || generando):
		spawnWiki()

func _on_TimerVirus_timeout():
	if(Manager.estadoJuegoActual == Manager.EstadoJuego.EN_JUEGO || generando):
		spawnWikiVirus()

func _on_TimerTerminos_timeout():
	if(Manager.estadoJuegoActual == Manager.EstadoJuego.EN_JUEGO || generando):
		spawnWikiTerminos()	

func ClickVirus(posicion:Vector2):	
	if castigo_virus == false:
		explotaVirus(posicion)
		#$TimerVirus.wait_time = 0.3
		castigo_virus = true
		yield(get_tree().create_timer(0.5),"timeout")
		#$TimerVirus.wait_time = 1
		castigo_virus = false

func _on_TimerFinal_timeout():
	Manager.estadoJuegoActual = Manager.EstadoJuego.EN_JUEGO

func mmostarX(x):
	var newWikiX = wikiX.instance()
	newWikiX.position = Vector2(x, get_viewport().size.y - 100)
	add_child(newWikiX);

func terminoscondiciones():
	pass


