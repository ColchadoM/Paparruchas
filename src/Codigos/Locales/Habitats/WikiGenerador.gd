extends Node2D

#Imports
onready var wikiDrag = preload("res://Escenas/Objetos/Ventana_drag.tscn")
onready var wikiX = preload("res://Escenas/Objetos/WikiX.tscn")
onready var wikiVirus = preload("res://Escenas/Objetos/VirusWiki.tscn")
onready var wikiTerminos = preload("res://Escenas/Objetos/Ventana_terminos.tscn")
onready var screenWidth = get_viewport().size.x
onready var playzoneStart = screenWidth * Constants.playableArea

var generandoNormal:bool = true
var puedeCompartir: bool = false
var generandoVirus:bool = false
var generandoTerminos: bool = false

var castigo_virus:bool = false

func _ready():
	Manager.connect("s_afueraPantalla",self,"mmostarX")
	Manager.connect("s_virusTimer", self, "ClickVirus")
	Manager.connect("s_terminoscondiciones", self, 'terminoscondiciones')
	Manager.connect("s_nextLevel",self, "updateGenerator")
	updateGenerator()

func updateGenerator():
	# Esto es una proqueria se debe cambiar por algo mas modular
	if(Manager.nivelActual == 1):
		generandoNormal = true
		puedeCompartir = true
	if(Manager.nivelActual == 2):
		generandoNormal = true
		puedeCompartir = true
	if(Manager.nivelActual == 3):
		generandoNormal = true
		puedeCompartir = true
		generandoVirus = true
	if(Manager.nivelActual == 4):
		generandoNormal = true
		puedeCompartir = true
		generandoVirus = true
		generandoTerminos = true

func spawnWiki():
	if !generandoNormal:
		return
	var wiki = wikiDrag.instance()
	var wikiH = wiki.get_node('Ventana_sprite').texture.get_height()
	var wikiW = wiki.get_node('Ventana_sprite').texture.get_width()
	wiki.position = Vector2(rand_range(playzoneStart + (wikiW/2),screenWidth -(wikiW/2)) , -(wikiH/2) - 50)
	add_child(wiki)

func spawnWikiVirus():
	if !generandoVirus:
		return
	var wikiVi = wikiVirus.instance()
	var wikiHV = wikiVi.get_node("WikiV").texture.get_height()
	var wikiWV = wikiVi.get_node("WikiV").texture.get_width()
	wikiVi.position = Vector2(rand_range(playzoneStart,screenWidth -(wikiWV/2)) + 100 , -(wikiHV/2) - 500)
	add_child(wikiVi)

func explotaVirus(posicion:Vector2):
	for i in range(10):
		var r_wiki_x = rand_range(-80,80)
		var r_wiki_y = rand_range(-80,80)-30
		var wikiVi = wikiVirus.instance()
		var wikiHV = wikiVi.get_node("WikiV").texture.get_height()
		var wikiWV = wikiVi.get_node("WikiV").texture.get_width()
		wikiVi.position = Vector2(posicion.x+(i*r_wiki_x),posicion.y+(i*r_wiki_y))
		add_child(wikiVi)
		yield(get_tree().create_timer(0.02),"timeout")
		
	
func spawnWikiTerminos():
	if !generandoTerminos:
		return
	var wiki = wikiTerminos.instance()
	var wikiH = wiki.get_node("Area2D/sprite_terminos").texture.get_height()*wiki.get_node("Area2D/sprite_terminos").scale.y
	var wikiW = wiki.get_node("Area2D/sprite_terminos").texture.get_width()*wiki.get_node("Area2D/sprite_terminos").scale.x
	wiki.position = Vector2(rand_range(playzoneStart + (wikiW/2),screenWidth -(wikiW/2)) , -(wikiH/2) - 50)
	add_child(wiki)

func _on_Timer_timeout():
	if(Manager.estadoJuegoActual == Manager.EstadoJuego.EN_JUEGO):
		spawnWiki()

func _on_TimerVirus_timeout():
	if(Manager.estadoJuegoActual == Manager.EstadoJuego.EN_JUEGO):
		spawnWikiVirus()

func _on_TimerTerminos_timeout():
	if(Manager.estadoJuegoActual == Manager.EstadoJuego.EN_JUEGO):
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


