extends Node2D
@export var enemy: PackedScene
@export var tower: PackedScene

var new_tower: Sprite2D
var _started: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_tower = tower.instantiate()
	new_tower.tower_cooldown = 1.0
	new_tower.tower_damage = 50
	
	add_child(new_tower)
	
	for i in range(0, 20):
		var new_enemy = enemy.instantiate()
		$EnemyPath.add_child(new_enemy)
		new_enemy.progress_ratio = randf_range(0.0, 0.8)
		new_enemy.speed = 100
		new_enemy.name = "Enemy %d" % (i+1)
		new_enemy.show()
		

var delta_time: float = 0.0

func _process(delta: float):
	delta_time += delta
	
	if not _started:
		if delta_time > 0.06:
			delta_time -= 0.06
			var position: Vector2 = get_global_mouse_position()
			
			new_tower.position = position

			if new_tower.get_node("PlacementCollider").overlaps_area($NonPlaceable):
				print(Time.get_time_string_from_system(), " cannot place")
		
		if Input.is_action_pressed("left_click"):
			if not new_tower.get_node("PlacementCollider").overlaps_area($NonPlaceable):
				_started = true
				new_tower.active = true
		#if $NonPlaceable.overlaps_area()

func _on_tower_area_entered(area: Area2D) -> void:
	print(Time.get_time_string_from_system(), area.name)
