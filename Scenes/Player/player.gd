extends CharacterBody2D

class_name Player

@export var FELL_OFF_Y: float = 1200

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var debug: Label = $Debug


const GRAVITY: float = 690.0
const JUMP_SPEED: float = -270.0
const MAX_SPEED: float = 350
const RUN_SPEED: float = 120.0
const MAX_FALL: float = 500
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _enter_tree() -> void:
	add_to_group(Constants.PLAYER_GROUP)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

# Logica fisica, movimento con collisioni
# ndipendente dal frame rate → anche se il gioco cala a 30 FPS, _physics_process() continua a girare a 60 chiamate/sec.
func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta
	
	if is_on_floor() and Input.is_action_just_pressed("jump") == true:
		velocity.y += JUMP_SPEED
	if is_equal_approx(velocity.x, 0) == false:
		sprite_2d.flip_h = velocity.x < 0
	velocity.x = RUN_SPEED * Input.get_axis("move_left", "move_right")
	velocity.y = clampf(velocity.y, JUMP_SPEED, MAX_SPEED)
	move_and_slide()
	_debug()
	_fell_off()

func _debug():
	var coord: String = ""
	coord += "Floor %s\n" % [is_on_floor()]
	coord += "V:%.1f, %.1f\n" % [velocity.x, velocity.y]
	coord += "P:%.1f, %.1f" % [global_position.x, global_position.y]
	debug.text = coord
	
func _fell_off():
	if global_position.y > FELL_OFF_Y:
		queue_free()
