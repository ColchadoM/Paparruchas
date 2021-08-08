extends Node2D

var particulas = preload("res://Escenas/Objetos/Estrellitas.tscn")
var particulas_virus = preload("res://Escenas/Objetos/virus_particula.tscn")

export(Manager.TipoDrop) var tipoDrop
export(NodePath) var posicion_estrellitas
export(bool) var emiteParticulas
export(bool) var shake
export(String, "Basura", "Compartir") var lugar
export(NodePath) var arean

func _ready():
	print(lugar)
	arean = get_node(arean) as Area2D
	posicion_estrellitas = get_node(posicion_estrellitas) as Position2D
	Manager.connect("s_droped",self,"droped")
	Manager.connect("s_paparruchometro_punto",self,"droped_e")

	
## cuando el proceso de comerse ventana acaba y es exitoso
#func droped():
#	print("dropeada")
#	if emiteParticulas:
#		particula_creada(particulas)
#	if shake:
#		shake()
		
func droped_e(punto, _lugar):
#	print(self.name)
	
	if _lugar == lugar:
		print(_lugar)
		if punto == 'malo':
			if emiteParticulas:
				particula_creada(particulas_virus)
			if shake:
				shake()
		elif punto == 'bueno':
			if emiteParticulas:
				particula_creada(particulas)
			if shake:
				shake()

		
func particula_creada(tipo_particula):
	#print("particles")
	var particula_instance = tipo_particula.instance()	
	particula_instance.position = posicion_estrellitas.position	
	particula_instance.emitting = true
	add_child(particula_instance)
	
func shake():
	$Sprite/Tween.interpolate_property($Sprite, 'scale', Vector2(1,1), Vector2(1.5,1.5), 0.4, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$Sprite/Tween.interpolate_property($Sprite, 'rotation', 0, -1, 0.4, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$Sprite/Tween.start()
	yield(get_tree().create_timer(0.41),"timeout")
	$Sprite/Tween.interpolate_property($Sprite, 'scale', Vector2(1.5,1.5), Vector2(1,1), 0.4, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$Sprite/Tween.interpolate_property($Sprite, 'rotation', -1, 0, 0.4, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$Sprite/Tween.start()
	
	

func _on_AreaCo_area_entered(area):
	Manager.emit_signal("s_edroped", tipoDrop, area, position, self.name)
#	print(self.name)
#	print(lugar)


func _on_AreaBa_area_entered(area):
	Manager.emit_signal("s_edroped", tipoDrop, area, position, self.name)
