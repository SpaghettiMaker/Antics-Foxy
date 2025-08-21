extends Node2D

const OBJECT_SCENES: Dictionary[Constants.ObjectType, PackedScene] = {
	Constants.ObjectType.BULLET_PLAYER: 
		preload("res://Scenes/Bullet/player_bullet.tscn"),
	Constants.ObjectType.BULLET_ENEMY: 
		preload("res://Scenes/Bullet/mob_bullet.tscn"),
	Constants.ObjectType.EXPLOSION: 
		preload("res://Scenes/Explosion/explosion.tscn"),
	Constants.ObjectType.PICKUP: 
		preload("res://Scenes/Fruit/fruit_pickup.tscn")
}
#Called when the node enters the SceneTree (e.g. upon instantiating, scene changing, or after calling add_child() in a script). If the node has children, its _enter_tree() callback will be called first, and then that of the children.
func _enter_tree() -> void:
	SignalHub.on_create_bullet.connect(on_create_bullet)
	SignalHub.on_create_object.connect(on_create_object)

func on_create_bullet(pos: Vector2, dir: Vector2, speed: float, ob_type: Constants.ObjectType) -> void:
	if OBJECT_SCENES.has(ob_type) == false:
		return
	var node_bullet: Bullet = OBJECT_SCENES[ob_type].instantiate()
	node_bullet.setup(pos, dir, speed)
	call_deferred("add_child", node_bullet)
	
func on_create_object(pos: Vector2, ob_type: Constants.ObjectType) -> void:
	if OBJECT_SCENES.has(ob_type) == false:
		return
	var new_obj: Node2D = OBJECT_SCENES[ob_type].instantiate()
	pos.y = pos.y - 25
	new_obj.global_position = pos
	call_deferred("add_child", new_obj)
