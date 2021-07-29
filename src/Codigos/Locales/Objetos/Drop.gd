extends Node2D

var particulas = preload("res://Escenas/Objetos/Estrellitas.tscn")

export var nombre = ""

func _ready():
	Manager.connect("s_droped",self, 'droped')


func _on_Area2D_area_entered(area):
	Manager.emit_signal("entro_basura", 'paparrucha', area, position)
	pass
	#$Sprite/Tween.interpolate_property($Sprite, 'scale', Vector2(1,1), Vector2(1.5,1.5), 0.4, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	#$Sprite/Tween.interpolate_property($Sprite, 'rotation', 0, 2, 0.4, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	#$Sprite/Tween.start()


func _on_Area2D_area_exited(area):
	pass
	#$Sprite/Tween.interpolate_property($Sprite, 'scale', Vector2(1.5,1.5), Vector2(1,1), 0.5, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	#$Sprite/Tween.interpolate_property($Sprite, 'rotation', 2, 0, 0.4, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	#$Sprite/Tween.start()

func droped():
	pass
#	var particula_instance = particulas.instance()
#	add_child(particula_instance)
#	particula_instance.position = self.position
#
#	particula_instance.start()
#
#	#yield(get_tree().create_timer(0.1), "timeout")
#	#particula_instance.emitting = true
#	print(particula_instance)
	
