extends Node

class_name LifeTimer

@export var life_time: float = 10.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(life_time).timeout
	get_parent().call_deferred("queue_free")
