extends Control


func _ready():
	for nivel in range($Grid_Niveles.get_child_count()):
		Manager.niveles.append(nivel+1)
	
	for nivel in $Grid_Niveles.get_children():
		if str2var(nivel.name) in range(Manager.nivelesDesbloqueados+1):
			nivel.disabled = false
			nivel.connect('pressed', self, 'level_button_pressed',
							[nivel.name]) # Connect the signal of all enabled buttons with an extra variable attached
		else:
			nivel.disabled = true #Disable all unlocked level buttons
	


func level_button_pressed(lvl_no):
	get_tree().change_scene("res://Node2D"+ lvl_no +".tscn") # Change scene to any selected level
