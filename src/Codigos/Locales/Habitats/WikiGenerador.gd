extends Node2D

#Imports
onready var wikiPaquete = preload("res://Escenas/Objetos/VentanaWiki.tscn")
onready var wikiDrag = preload("res://Escenas/Objetos/Ventana_drag.tscn")
onready var wikiX = preload("res://Escenas/Objetos/WikiX.tscn")
onready var wikiVirus = preload("res://Escenas/Objetos/VirusWiki.tscn")
onready var screenWidth = get_viewport().size.x
onready var playzoneStart = screenWidth * Constants.playableArea

export var dragableWindows:bool = true
export var generando:bool = false

var castigo_virus:bool = false

func _ready():
	Manager.connect("s_afueraPantalla",self,"mmostarX")
	Manager.connect("s_virusTimer", self, "ClickVirus")

func spawnWiki():
	var wiki
	if(dragableWindows):
		wiki = wikiDrag.instance()
	else:
		wiki = wikiPaquete.instance()
	var wikiH = wiki.texture.get_height()
	var wikiW = wiki.texture.get_width()
	wiki.position = Vector2(rand_range(playzoneStart + (wikiW/2),screenWidth -(wikiW/2)) , -(wikiH/2) - 50)
	add_child(wiki)

func spawnWikiVirus():
	
	var wikiVi = wikiVirus.instance()
	var wikiHV = wikiVi.get_node("WikiV").texture.get_height()
	var wikiWV = wikiVi.get_node("WikiV").texture.get_width()
	wikiVi.position = Vector2(rand_range(playzoneStart,screenWidth -(wikiWV/2)) , -(wikiHV/2) - 500)
	add_child(wikiVi)

func _on_Timer_timeout():
	if(Manager.estadoJuegoActual == Manager.EstadoJuego.EN_JUEGO || generando):
		spawnWiki()

func _on_TimerVirus_timeout():
	if(Manager.estadoJuegoActual == Manager.EstadoJuego.EN_JUEGO || generando):
		spawnWikiVirus()

func ClickVirus():
	if castigo_virus == false:
		$TimerVirus.wait_time = 0.3
		castigo_virus = true
		yield(get_tree().create_timer(8),"timeout")
		$TimerVirus.wait_time = 1
		castigo_virus = false

func _on_TimerFinal_timeout():
	Manager.estadoJuegoActual = Manager.EstadoJuego.EN_JUEGO

func mmostarX(x):
	var newWikiX = wikiX.instance()
	newWikiX.position = Vector2(x, get_viewport().size.y - 100)
	add_child(newWikiX);

