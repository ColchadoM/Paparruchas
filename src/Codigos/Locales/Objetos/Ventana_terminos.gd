extends Node2D

onready var sprite_textura = get_node("Area2D/sprite_terminos")
onready var ventana_full = $Ventana_full
onready var tween_vc = $Area2D/Tween
onready var tween_vg = $Ventana_full/Tween

export var debug_tipo: bool = false
export var r_tipo: int
enum tipos {RAPIDO, LENTO}
var v_juego_acepta: float
var v_juego_cancela: float

var clickeadaV: bool = false
var deleteadaV: bool = false
var abierta: bool = false
var speedV: float = 400
onready var screenWidth = get_viewport().size.x
onready var screenHeight = get_viewport().size.y

func _ready():
	if debug_tipo:
		_crea_tipo()		
	else:
		r_tipo = floor(rand_range(0, tipos.size()))
		_crea_tipo()

func _physics_process(delta):
	if(!abierta):
		position.y += speedV * delta
		#print(speedV * delta)
		if(position.y > get_viewport().size.y + sprite_textura.texture.get_height()):
			deleteadaV = true;
			#closeAnimation()


func _on_Area2D_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("Toca"):
		abierta = true
		Manager.emit_signal("s_terminoscondiciones")
		v_chica_desaparece()
		v_grande_aparece()		
		yield(get_tree().create_timer(0.29),"timeout")
		Engine.time_scale = 0.1
		pass # Replace with function body.
		

func v_chica_desaparece():
	tween_vc.interpolate_property($".", 'position', $".".position, Vector2(screenWidth/2,screenHeight/2), 0.3, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)	
	tween_vc.start()	
	yield(get_tree().create_timer(0.29),"timeout")
	$Area2D.queue_free()

func v_grande_aparece():
	ventana_full.visible = true
	tween_vg.interpolate_property(ventana_full, 'scale', ventana_full.scale, Vector2(1,1), 0.3, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)	
	tween_vg.start()	


func _on_Aceptar_input_event(viewport, event, shape_idx):	
	if Input.is_action_just_pressed("Toca") && abierta:
		Manager.emit_signal("s_termina_terminos")
		Engine.time_scale = v_juego_acepta
		$Aceptar.queue_free()
		$Cancelar.queue_free()
		tween_vg.interpolate_property(ventana_full, 'scale', ventana_full.scale, Vector2(0,0), 0.3, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)	
		tween_vg.start()
		$Timer_efecto.start()
		pass # Replace with function body.


func _on_Cancelar_input_event(viewport, event, shape_idx):	
	if Input.is_action_just_pressed("Toca") && abierta:		
		Manager.emit_signal("s_termina_terminos")
		Engine.time_scale = v_juego_cancela
		$Aceptar.queue_free()
		$Cancelar.queue_free()
		tween_vg.interpolate_property(ventana_full, 'scale', ventana_full.scale, Vector2(0,0), 0.3, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)	
		tween_vg.start()
		$Timer_efecto.start()
		pass # Replace with function body.


func _crea_tipo():
	match r_tipo:
		tipos.LENTO:
			v_juego_acepta = 0.3
			v_juego_cancela = 1
			$Timer_efecto.wait_time = 8 * v_juego_acepta
			$Ventana_full/RichTextLabel.text = $Ventana_full/RichTextLabel.text+"I. La velocidad del juego disminuirá."
			#print('lento')
		tipos.RAPIDO:
			v_juego_acepta = 1.8
			v_juego_cancela = 1
			$Timer_efecto.wait_time = 8 * v_juego_acepta
			$Ventana_full/RichTextLabel.text = $Ventana_full/RichTextLabel.text+"I. La velocidad del juego se incrementará."
			#print('rapido')


func _on_Timer_efecto_timeout():
	Engine.time_scale = 1
