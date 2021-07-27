extends Sprite

var seleccionado = false
var gravedad = 4
var tipo_ventana = 'paparrucha'
onready var area_ventana = $Area2D 
export var puntaje = 5
var metido = false
var posicion_rest

func _ready():
	Senales.connect("entro_basura",self,'_entra_basura')
	$Tween.interpolate_property(self, 'scale', self.scale, Vector2(0,0), 0.8, Tween.TRANS_SINE, Tween.EASE_OUT)
	pass # Replace with function body.

func _on_Area2D_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("Toca"):
		seleccionado = true

func _physics_process(delta):
	
	if seleccionado:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
		look_at(get_global_mouse_position())
		
	else:
		position.y += gravedad
		rotation = lerp_angle(rotation, 0, 10 * delta)
	
	if metido:
		global_position = lerp(global_position, posicion_rest, 25 * delta)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.pressed:
			seleccionado = false

func _entra_basura(tipo, area, posicion):
	posicion_rest = posicion
	if area == area_ventana:
		metido = true
		area_ventana.queue_free()
		if tipo_ventana == tipo:
			Senales.emit_signal("cambia_paparruchometro", puntaje)
			_desaparce()
		else:
			Senales.emit_signal("cambia_paparruchometro", -puntaje)
			_desaparce()

func _desaparce():
	$Tween.start()
	yield(get_tree().create_timer(1), "timeout")
	queue_free()
