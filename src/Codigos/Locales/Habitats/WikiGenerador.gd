extends Node2D

#Imports
onready var wikiPaquete = preload("res://Escenas/Objetos/VentanaWiki.tscn")
onready var wikiX = preload("res://Escenas/Objetos/WikiX.tscn")

var generating:bool = false;

func _ready():
	Manager.connect("s_afueraPantalla",self, "mmostarX")
	
func _process(delta):
	pass

func spawnWiki():
	var screenWidth = get_viewport().size.x
	var playzoneStart = screenWidth * Constants.playableArea;
	var wiki = wikiPaquete.instance();
	var wikiH = wiki.get_node("Sprite").texture.get_height();
	var wikiW = wiki.get_node("Sprite").texture.get_width();
	wiki.position = Vector2(rand_range(playzoneStart + (wikiW/2),screenWidth -(wikiW/2)) , -(wikiH/2) - 100);
	add_child(wiki);

func _on_Timer_timeout():
	if(Manager.estadoJuegoActual == Manager.EstadoJuego.EN_JUEGO):
		spawnWiki()
	
func _on_TimerInicio_timeout():
	Manager.estadoJuegoActual = Manager.EstadoJuego.EN_JUEGO
	
func mmostarX(x):
	var newWikiX = wikiX.instance()
	newWikiX.position = Vector2(x, get_viewport().size.y - 100)
	add_child(newWikiX);
