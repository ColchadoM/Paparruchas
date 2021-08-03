extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Manager.connect("s_empezarNivel", self, 'inicia_transicion')
	#inicia_transicion()
	pass # Replace with function body.


func inicia_transicion():
	print('hdeuhdeu')
	$espiral/AnimationPlayer.play("Crece")
