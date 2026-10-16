extends Sprite2D
@export var tower_cooldown: float = 1.0
@export var tower_damage: float = 1.0
@export var active: bool = false
@export_enum("first", "strongest", "last") var target: String = "first"

var delta_time: float = 0.0 # my beloved

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	delta_time += delta
	
	if (delta_time > 0.5):
		delta_time -= 0.5
		if not $CooldownTimer.is_stopped() or not active:
			return
		
		print("go my tower blast ", Time.get_time_string_from_system())
		
		#var area: Area2D = $"."
		#
		var enemies: Array[Area2D] = $WeaponRange.get_overlapping_areas()
		var to_attack: PathFollow2D
		
		if enemies.size() == 0:
			return
		
		match target:
			"first":
				for enemy in enemies:
					if to_attack == null or enemy.get_parent().progress_ratio > to_attack.progress_ratio:
						to_attack = enemy.get_parent()
			"strongest":
				for enemy in enemies:
					if to_attack == null or enemy.get_parent().health > to_attack.health:
						to_attack = enemy.get_parent()
			"last":
				for enemy in enemies:
					if to_attack == null or enemy.get_parent().progress_ratio < to_attack.progress_ratio:
						to_attack = enemy.get_parent()
				
		if to_attack != null:
			to_attack.hit(tower_damage)
			$CooldownTimer.wait_time = tower_cooldown
			$CooldownTimer.start()



#func _on_area_entered(area: Area2D) -> void:
	#if not $CooldownTimer.is_stopped():
		#return
	#
	#print(Time.get_time_string_from_system(), "Fire!!")
	#area.get_parent().hit(randi_range(20, 50))
	#$CooldownTimer.wait_time = tower_cooldown
	#$CooldownTimer.start()
