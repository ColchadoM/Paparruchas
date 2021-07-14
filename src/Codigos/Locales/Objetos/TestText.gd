extends Label

func _ready():
	var managerNode = get_tree().get_root().find_node("Manager", true,false)
	managerNode.connect("s_desempaparruchar",self, "updateText")
	managerNode.connect("s_empaparruchar",self, "updateText")
	text = String(Manager.empaparruchometro)

func updateText():
	text = String(Manager.empaparruchometro)
