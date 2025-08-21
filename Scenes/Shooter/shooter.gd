extends Node2D

class_name Shooter

@export var speed: float = 50.0
@export var shoot_delay: float = 1.0
@export var bullet_key: Constants.ObjectType = Constants.ObjectType.BULLET_PLAYER

@onready var shoot_timer: Timer = $Timer
@onready var shoot_audio: AudioStreamPlayer2D = $AudioStreamPlayer2D

var _can_shoot:bool = true

func _ready() -> void:
	shoot_timer.wait_time = shoot_delay
	
func _process(delta: float) -> void:
	pass

func shoot(direction: Vector2) -> void:
	if _can_shoot == false:
		return
	_can_shoot = false
	SignalHub.emit_on_create_bullet(
		global_position, 
		direction, 
		speed, 
		bullet_key
	)
	shoot_timer.start()
	shoot_audio.play()
	

func _on_timer_timeout() -> void:
	_can_shoot = true

func _on_audio_stream_player_2d_finished() -> void:
	pass # Replace with function body.
