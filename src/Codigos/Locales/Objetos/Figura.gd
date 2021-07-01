extends Control

export(Constants.FIGURA) var figura;

func _ready():
	var figures_data = {
		Constants.FIGURA.Triangulo: load("res://Codigos/Locales/Objetos/Triangulo.tres"),
		Constants.FIGURA.Cuadro: load("res://Codigos/Locales/Objetos/Cuadro.tres"),
		Constants.FIGURA.Estrella: load("res://Codigos/Locales/Objetos/Estrella.tres")
	}
	var image = get_node("TextureRect")
	image.texture = figures_data[figura].image
