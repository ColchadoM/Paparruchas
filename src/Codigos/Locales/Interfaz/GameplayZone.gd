extends Control

var sizeX:int = 1960;
var lastWidth:int = 0;

func _ready():
	changeWidth()

func _process(delta):
	if(lastWidth != get_viewport().size.x):
		changeWidth()
		
func changeWidth():
	sizeX = get_viewport().size.x -(get_viewport().size.x * Constants.playableArea )
	set_size(Vector2(sizeX, get_viewport().size.y))
	lastWidth = get_viewport().size.x
