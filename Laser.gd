extends Area2D

const SCREEN_WIDTH = 320
const MOVE_SPEED = 500
var sprite_dir = 0
func _process(delta: float) -> void:
	position += Vector2(MOVE_SPEED*delta,sprite_dir * MOVE_SPEED*delta)
	if position.x  >= SCREEN_WIDTH + 8:
		queue_free()

func _on_laser_area_entered(area: Area2D) -> void:
	if area.is_in_group("asteroid"):
		queue_free()

func set_sprite_dir(i):
	sprite_dir = i
	if i == 0:
		pass
	else:
		$sprite.rotation_degrees = i * 45
		$damage_zone.rotation_degrees = i * 45
