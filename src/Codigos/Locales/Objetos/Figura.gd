extends Control

export(Constants.FIGURA) var tipo;

func _ready():
	var figures_data = {
		Constants.FIGURA.Triangulo: load("res://Codigos/Locales/Objetos/Triangulo.tres"),
		Constants.FIGURA.Cuadro: load("res://Codigos/Locales/Objetos/Cuadro.tres"),
		Constants.FIGURA.Estrella: load("res://Codigos/Locales/Objetos/Estrella.tres"),
		Constants.FIGURA.CircM: load("res://Codigos/Locales/Objetos/CircM.tres")
	}
	var image = get_node("Img")
	image.texture = figures_data[tipo].image
