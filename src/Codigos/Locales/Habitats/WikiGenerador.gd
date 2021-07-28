extends Node2D

#Imports
onready var wikiPaquete = preload("res://Escenas/Objetos/VentanaWiki.tscn")
onready var wikiDrag = preload("res://Escenas/Objetos/Ventana_drag.tscn")
onready var wikiX = preload("res://Escenas/Objetos/WikiX.tscn")

var dragableWindows:bool = true

func _ready():
	Manager.connect("s_afueraPantalla",self,"mmostarX")

func spawnWiki():
	var screenWidth = get_viewport().size.x
	var playzoneStart = screenWidth * Constants.playableArea
	var wiki
	if(dragableWindows):
		wiki = wikiDrag.instance()
	else:
		wiki = wikiPaquete.instance()
	var wikiH = wiki.texture.get_height()
	var wikiW = wiki.texture.get_width()
	wiki.position = Vector2(rand_range(playzoneStart + (wikiW/2),screenWidth -(wikiW/2)) , -(wikiH/2) - 50)
	add_child(wiki)

func _on_Timer_timeout():
	if(Manager.estadoJuegoActual == Manager.EstadoJuego.EN_JUEGO):
		spawnWiki()

func _on_TimerFinal_timeout():
	Manager.estadoJuegoActual = Manager.EstadoJuego.EN_JUEGO

func mmostarX(x):
	var newWikiX = wikiX.instance()
	newWikiX.position = Vector2(x, get_viewport().size.y - 100)
	add_child(newWikiX);

