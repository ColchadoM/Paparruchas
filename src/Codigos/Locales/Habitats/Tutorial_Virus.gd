extends Node2D

var estrellitas = preload("res://Escenas/Objetos/Estrellitas.tscn")
var completado = false

func _ready():	
	if Manager.nivelActual == 3:
		visible = true
	else:
		z_index = -10
		queue_free()
	$Mano/AnimationPlayer.play("arrastra")
	pass


func _on_Area2D_area_entered(area):
	if !completado:
		completado = true
		particula_creada(estrellitas)
		$ClicBien.play()
		yield(get_tree().create_timer(0.5), "timeout")
		$Tween.interpolate_property(self, 'modulate', Color(1,1,1,1), Color(1,1,1,0), 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
		yield(get_tree().create_timer(0.3), "timeout")
		visible = false
		z_index = -10
		$Wiki.queue_free()
		$Wiki2.queue_free()
		$Wiki3.queue_free()
		$Wiki4.queue_free()
		$Wiki5.queue_free()
		$Wiki6.queue_free()		
		$Wiki7.queue_free()
		$WikiGenerator.queue_free()
#		yield(get_tree().create_timer(0.2), "timeout")
		Manager.emit_signal("s_acaba_tutorial")
		#queue_free()
		
	#pass # Replace with function body.


func particula_creada(tipo_particula):
	var particula_instance = tipo_particula.instance()	
	particula_instance.position = $Randy.position	
	particula_instance.emitting = true
	add_child(particula_instance)


func _on_Timer_ayuda_timeout():
	$Control/textos_ayuda/Tween.interpolate_property($Control/textos_ayuda, 'modulate', Color(1,1,1,0), Color(1,1,1,0.7), 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Control/textos_ayuda/Tween.start()
	pass # Replace with function body.
