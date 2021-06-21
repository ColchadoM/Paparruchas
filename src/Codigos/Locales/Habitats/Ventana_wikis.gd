extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var dentro = false
var opcion = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_opcion_1_mouse_entered():
	opcion = 1
	dentro = true

func _on_opcion_1_mouse_exited():
	opcion = 0
	dentro = false
		

func _on_opcion_2_mouse_entered():
	opcion = 2
	dentro = true
	
func _on_opcion_2_mouse_exited():
	opcion = 0
	dentro = false


func _input(event):
	if Input.is_mouse_button_pressed(1) && dentro:
		print('correcto')
		



