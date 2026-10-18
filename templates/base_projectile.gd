class_name ProjectileData
extends Resource

@export_group("Behavior")
@export var behavior_scene: PackedScene

@export_group("Lifetime")
@export var life: int = 1 ## How many enemies this projectile can hit
@export var max_distance: float = 600.0

@export_group("Movement")
#@export var target_position: Vector2 = Vector2.ZERO
@export var speed: float = 300.0

@export_group("Damage")
@export var damage: int = 10
