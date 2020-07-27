extends Area2D

const MOVE_SPEED = 150.0
const SCREEN_WIDTH = 320
const SCREEN_HEIGHT = 180
var laser_scene = preload("res://Laser.tscn")
var explosion_scene = preload("res://explosion.tscn")
var can_shoot = true
const laser_dir = [[Vector2(9,5),0],[Vector2(9,-5),0],[Vector2(9,7.5),0.5],[Vector2(9,-7.5),-0.5],[Vector2(9,10),1],[Vector2(9,-10),-1]]
var laser_beams = 2
onready var stage_node = get_parent()
onready var timer = $reload_timer

signal destroyed()

func _process(delta: float) -> void:
	var input_dir = Vector2()
	if(Input.is_action_pressed("ui_up")):
		input_dir.y -= 1.0
	if(Input.is_action_pressed("ui_down")):
		input_dir.y += 1.0
	if(Input.is_action_pressed("ui_left")):
		input_dir.x -= 1.0
	if(Input.is_action_pressed("ui_right")):
		input_dir.x += 1.0
	
	position += (delta * MOVE_SPEED) * input_dir
	
	if(position.x < 0.0 + 8):
		position.x = 0.0 + 8
	elif position.x > SCREEN_WIDTH - 8:
		position.x = SCREEN_WIDTH - 8
	if position.y < 0.0 + 8:
		position.y = 0.0 + 8
	elif position.y > SCREEN_HEIGHT - 8:
		position.y = SCREEN_HEIGHT - 8
	
	if(Input.is_action_just_pressed("ui_accept") and can_shoot):
		can_shoot = false
		for i in min(laser_beams,laser_dir.size()):
			var laser_instance = laser_scene.instance()
			laser_instance.position = position + laser_dir[i][0]
			laser_instance.set_sprite_dir(laser_dir[i][1])
			stage_node.add_child(laser_instance)
		timer.start()


func _on_reload_timer_timeout() -> void:
	can_shoot = true


func _on_player_area_entered(area: Area2D) -> void:
	
	if area.is_in_group("asteroid"):
		queue_free()
		var explosion_instance = explosion_scene.instance()
		explosion_instance.position = position
		stage_node.add_child(explosion_instance)
		emit_signal("destroyed")
