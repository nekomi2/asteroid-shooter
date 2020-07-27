extends Sprite

const SCREEN_WIDTH = 320
var scroll_speed = 30.0

func _ready() -> void:
	randomize()
func _process(delta: float) -> void:
	position.x -= scroll_speed * delta
	
	if position.x <= -SCREEN_WIDTH:
		position.x += SCREEN_WIDTH
