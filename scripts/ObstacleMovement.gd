extends AnimatableBody2D

signal exited
var height_offset:float=0
var rng = RandomNumberGenerator.new()
var animated_sprite_2d

func _ready():
	if get_meta("type") == "higher":
		animated_sprite_2d = $AnimatedSprite2D
		height_offset = rng.randf_range(-50.0, 150.0)
		global_position.y += height_offset
	if animated_sprite_2d:
		animated_sprite_2d.play("flap") 
		
func _physics_process(delta):
	global_position.x -= get_meta("move_speed") * delta
	GameManager.add_score(get_meta("move_speed") * delta)

func _on_hitbox_body_entered(body):
	if body.is_in_group("player"):
		body.die()

func _on_visible_on_screen_notifier_2d_screen_exited():
	emit_signal("exited")
	queue_free()
