extends Area2D

class_name FruitPickUp

@export var points: int = 2
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var pickup_audio: AudioStreamPlayer2D = $PickupAudio 

func _ready() -> void:
	var ln: Array[String] = []
	for an_name in sprite.sprite_frames.get_animation_names():
		ln.push_back(an_name)
	sprite.animation = ln.pick_random()

func _on_area_entered(area: Area2D) -> void:
	hide()
	set_deferred("monitoring", false)
	pickup_audio.play()


func _on_pickup_audio_finished() -> void:
	queue_free()
