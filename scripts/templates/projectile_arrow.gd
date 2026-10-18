extends Area2D
class_name ProjectileController

@export var data: ProjectileData
@export var target_position: Vector2 = Vector2.ZERO

var velocity: Vector2 = Vector2.ZERO
var _life = 1
var _last_hit: int = 0 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity = (target_position - global_position).normalized() * data.speed
	rotation = velocity.angle()
	_life = data.life

func _physics_process(delta: float) -> void:
	global_position += velocity * delta

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	if _life <= 0:
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	var enemy: EnemyController = area.get_parent()
	
	if _life > 0 and enemy.get_instance_id() != _last_hit:
		enemy.hit(data.damage)
		_last_hit = enemy.get_instance_id()
		_life -= 1
	

func _on_screen_exit() -> void:
	queue_free()
