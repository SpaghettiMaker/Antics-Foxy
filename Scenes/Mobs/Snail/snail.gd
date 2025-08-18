extends MobBase

@onready var ray_cast: RayCast2D = $RayCast2D

func _ready() -> void:
	speed = 20.0

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	velocity.y += delta * _gravity
	velocity.x += (speed if animated_sprite_2d.flip_h == true else -speed) * delta
	move_and_slide()
	_flip_me()

func _flip_me() -> void:
	if is_on_wall() or !ray_cast.is_colliding():
		animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h
		ray_cast.position.x = -ray_cast.position.x
