extends Sprite

onready var area_ventana = $Area2D 

var tipo_ventana = 'paparrucha'
var arrastrando = false
var speed = 180
var metido = false
var posicion_rest

export var puntaje = 5

func _ready():
	Senales.connect("entro_basura",self,'entra_basura')
	#$Tween.interpolate_property(self, 'scale', self.scale, Vector2(0,0), 0.8, Tween.TRANS_SINE, Tween.EASE_OUT)

func _physics_process(delta):
	if arrastrando:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
		look_at(get_global_mouse_position())
	else:
		position.y += speed * delta
		rotation = lerp_angle(rotation, 0, 10 * delta)
	if metido:
		global_position = lerp(global_position, posicion_rest, 25 * delta)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.pressed:
			arrastrando = false

func _on_Area2D_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("Toca"):
		print("toca")
		arrastrando = true

func entra_basura(tipo, area, posicion):
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
