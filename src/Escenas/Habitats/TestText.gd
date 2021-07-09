extends RichTextLabel

func _ready():
	text = String(Manager.empaparruchometro)

func updateText():
	text = String(Manager.empaparruchometro)
