extends Node2D

var particulas = preload("res://Escenas/Objetos/Estrellitas.tscn")

export(Manager.TipoDrop) var tipoDrop
export(NodePath) var posicion_estrellitas
export(bool) var emiteParticulas
export(bool) var shake

func _ready():
	posicion_estrellitas = get_node(posicion_estrellitas) as Position2D

func particula_creada():
	var particula_instance = particulas.instance()
	particula_instance.position = posicion_estrellitas.position
	particula_instance.emitting = true
	add_child(particula_instance)
	
func shake():
	print("shake")
	$Sprite/Tween.interpolate_property($Sprite, 'scale', Vector2(1,1), Vector2(1.5,1.5), 0.4, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$Sprite/Tween.interpolate_property($Sprite, 'rotation', 0, 2, 0.4, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$Sprite/Tween.start()

func _on_Area2D_area_entered(area):
	Manager.emit_signal("s_edroped", tipoDrop, area, position)
	
func _on_Area2D_area_exited(area):
	pass
	#$Sprite/Tween.interpolate_property($Sprite, 'scale', Vector2(1.5,1.5), Vector2(1,1), 0.5, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	#$Sprite/Tween.interpolate_property($Sprite, 'rotation', 2, 0, 0.4, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	#$Sprite/Tween.start()

func droped():
	if emiteParticulas:
		particula_creada()
	if shake:
		shake()
