extends Node2D
@export var enemy: PackedScene
@export var tower: PackedScene

var new_tower: Sprite2D
var _placed: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_tower = tower.instantiate() as TowerController
	new_tower.tower_projectile = new_tower.tower_projectile.duplicate()
	new_tower.tower_cooldown = 1.0
	new_tower.tower_damage = 50
	
	add_child(new_tower)
	
	for i in range(0, 20):
		var new_enemy = enemy.instantiate() as EnemyController
		new_enemy.speed = 100
		new_enemy.health = randi_range(100, 500)
		new_enemy.name = "Enemy %d" % (i+1)
		$EnemyPath.add_child(new_enemy)
		new_enemy.progress_ratio = randf_range(0.0, 0.8)
		new_enemy.show()
		

var delta_time: float = 0.0

func _process(delta: float):
	delta_time += delta
	
	if _placed < 2:
		if delta_time > 0.06:
			delta_time -= 0.06
			var position: Vector2 = get_global_mouse_position()
			
			new_tower.position = position

			if new_tower.get_node("PlacementCollider").overlaps_area($NonPlaceable):
				print(Time.get_time_string_from_system(), " cannot place")
		
		if Input.is_action_pressed("left_click"):
			var placement: Area2D = new_tower.get_node("PlacementCollider")
			var overlaps: Array[Area2D] = placement.get_overlapping_areas()
			
			var can_place: bool = true
			for c in overlaps:
				if c == $NonPlaceable:
					can_place = false
				elif c.name == "PlacementCollider":
					can_place = false
					
			
			if can_place and $PlacementTimer.is_stopped():
				_placed += 1
				$PlacementTimer.start()
				new_tower.active = true
				if _placed != 2:
					new_tower = tower.instantiate() as TowerController
					new_tower.tower_projectile = new_tower.tower_projectile.duplicate()
					new_tower.tower_cooldown = 0.05
					new_tower.tower_damage = 10
					new_tower.tower_projectile.life = 2
					add_child(new_tower)
		#if $NonPlaceable.overlaps_area()

func _on_tower_area_entered(area: Area2D) -> void:
	print(Time.get_time_string_from_system(), area.name)
