extends Label

func _ready():
	Manager.connect("s_desempaparruchar",self, "updateText")
	Manager.connect("s_empaparruchar",self, "updateText")
	text = String(Manager.empaparruchometroActual)

func updateText():
	text = String(Manager.empaparruchometroActual)
