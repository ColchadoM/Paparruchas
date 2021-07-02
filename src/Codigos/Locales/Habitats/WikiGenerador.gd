extends Node2D

#Imports
onready var wikiPaquete = preload("res://Escenas/Habitats/VentanaWiki.tscn")

var generating:bool = false;

func _ready():
	spawnWiki()
	
func _process(delta):
	pass
	
func _on_Timer_timeout():
	spawnWiki()

func spawnWiki():
	var screenWidth = get_viewport().size.x
	var playzoneStart = screenWidth * Constants.playableArea;
	var wiki = wikiPaquete.instance();
	var wikiH = wiki.get_node("Sprite").texture.get_height();
	var wikiW = wiki.get_node("Sprite").texture.get_width();
	wiki.position = Vector2(rand_range(playzoneStart + (wikiW/2),screenWidth -(wikiW/2)) , -(wikiH/2) - 100);
	add_child(wiki);
