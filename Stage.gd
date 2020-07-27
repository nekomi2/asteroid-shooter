extends Node2D

const SCREEN_WIDTH = 320
const SCREEN_HEIGHT = 180

var is_game_over = false
var asteroid = preload("res://Asteroid.tscn")
var score = 0
var extra_beams = 0
onready var score_display = $ui/score
onready var timer = $spawn_timer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$player.connect("destroyed",self,"on_player_destroyed")

func _input(event: InputEvent) -> void:
	if(Input.is_action_just_pressed("ui_cancel")):
		get_tree().quit()
	if is_game_over and Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene("res://Stage.tscn")

func on_player_destroyed():
	$ui/retry.show()
	is_game_over = true


func _on_spawn_timer_timeout() -> void:
	timer.wait_time *= 0.99
	var asteroid_instance = asteroid.instance()
	asteroid_instance.position = Vector2(SCREEN_WIDTH + 8,rand_range(0,SCREEN_HEIGHT))
	asteroid_instance.move_speed += score
	asteroid_instance.connect("score",self,"_on_player_score")
	add_child(asteroid_instance)

func _on_player_score():
	score += 1
	score_display.text = "Score: " + str(score)
	if(score / ((extra_beams+1) * 10) == 1): 
		extra_beams += 1
		$player.laser_beams += extra_beams
