extends PathFollow2D

signal died

var shake_strength: float = 0.0
var shake_fade: float = 5.0

@export var speed: float = 200
@export var health: int = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.text = str(health)
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $"..".get_class() != "Path2D":
		return

	if shake_strength > 1:
		shake_strength = lerpf(shake_strength, 0, shake_fade * delta)
		$Sprite2D.offset = Vector2(
			randf_range(-shake_strength, shake_strength),
			randf_range(-shake_strength, shake_strength)
		)
	else:
		$Sprite2D.offset = Vector2.ZERO
	
	#print($".".progress_ratio)
	if $".".progress_ratio != 1.0:
		$".".progress_ratio += (speed * delta) / $"..".curve.get_baked_length()
	else:
		$".".progress_ratio = 0.0
		
	


func hit(damage: int) -> void:
	health -= damage
	$Label.text = str(health)
	shake_strength = 100.0
	
	print("%s took %d damage!" % [$".".name, damage])
	
	if health <= 0:
		died.emit()
		queue_free()
