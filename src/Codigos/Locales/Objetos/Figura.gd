extends Control

func _ready():
	var class_data = load("res://Codigos/Locales/Objetos/Triangulo.tres");
	var image = get_node("TextureRect")
	image.texture = class_data.image
