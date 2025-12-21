extends CharacterBody2D

@export var jump_speed := -800.0
@export var gravity := 1800.0
@onready var animated_sprite_2d = $AnimatedSprite2D

signal player_died()

var is_alive := true

func _ready():
	GameManager.player = self
	player_died.connect(GameManager._on_player_died)
	animated_sprite_2d.play("fall")
		
func _physics_process(delta):
	if not is_alive:
		return
	# Apply gravity
	velocity.y += gravity * delta

	# Jump (space or touch)
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = jump_speed
		animated_sprite_2d.play("boost")

	# Move player
	move_and_slide()

func update_animation():
	if not is_alive:
		return

	if velocity.y < 0:
		if animated_sprite_2d.animation != "boost":
			animated_sprite_2d.play("boost")
	else:
		if animated_sprite_2d.animation != "fall":
			animated_sprite_2d.play("fall")
			
func die():
	is_alive = false
	player_died.emit()

	# Reset game, play animation, etc…

