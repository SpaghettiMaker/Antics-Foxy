extends CharacterBody2D

class_name MobBase

@export var points: int = 0
@export var speed: float = 30.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var _gravity: float = 690.0
var _player_ref: Player 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_player_ref = get_tree().get_first_node_in_group(Constants.PLAYER_GROUP)
	if _player_ref == null:
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	_fell_off()

func _fell_off():
	if global_position.y > 900:
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	pass # Replace with function body.

func _on_hit_box_area_entered(area: Area2D) -> void:
	_die()

func _die():
	SignalHub.emit_on_create_object(position, Constants.ObjectType.EXPLOSION)
	SignalHub.emit_on_create_object(position, Constants.ObjectType.PICKUP)
	set_physics_process(false)
	queue_free()
