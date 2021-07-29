extends Node2D

var estrellas = preload("res://Escenas/Objetos/Estrellitas.tscn")
var material_estrella = preload("res://Recursos/Visuales/Materiales/estrellitas_material.tres")

func _ready():
	Senales.connect("_droped", self, '_particulas')
	#_carga_particulas()
	pass

func _particulas(puntos):
	var instance_particulas = estrellas.instance()
	instance_particulas.position = $Basura.position
	add_child(instance_particulas)
	

func _carga_particulas():
	var particula_lag = Particles2D.new()
	particula_lag.material = material_estrella
	particula_lag.one_shot = true
	particula_lag.emitting = true
	add_child(particula_lag)
