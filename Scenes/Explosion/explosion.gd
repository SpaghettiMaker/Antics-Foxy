extends AnimatedSprite2D



@onready var audio_damage: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	audio_damage.play()

func _on_animation_finished() -> void:
	queue_free()

func _on_audio_stream_player_2d_finished() -> void:
	pass # Replace with function body.
