extends Sprite

func _ready():
	var tween = get_node("Tween")
	tween.interpolate_property(self, "scale",
			Vector2(0, 0), Vector2(0.5, 0.5), 0.2,
			Tween.TRANS_LINEAR , Tween.EASE_IN)
	tween.start()
	get_node("Timer").start()


func _on_Timer_timeout():
	var tween = get_node("Tween")
	tween.interpolate_property(self, "scale",
			Vector2(0.5, 0.5), Vector2(0, 0), 0.2,
			Tween.TRANS_BACK , Tween.EASE_IN)
	tween.start()
