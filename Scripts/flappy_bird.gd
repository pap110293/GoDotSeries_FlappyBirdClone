extends CharacterBody2D

@export var forceUp:float = 300
@export var max_rotation = 45  # Maximum rotation angle in degrees
@export var rotation_speed = 5  # Speed of rotation adjustment

@onready var animated_sprite = $AnimatedSprite2D
@onready var collision_polygon = $CollisionPolygon2D

signal died

var is_die:bool = false
var is_game_start:bool = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	%GameManager.game_start.connect(_on_game_start)

func _physics_process(delta:float):
	handle_movement(delta)
	
	if is_die:
		collision_polygon.disabled = true
		
	
func handle_movement(delta:float)->void:
	if !is_die and is_game_start:
		handle_gravity(delta)
		handle_rotation(delta)
		handle_input()
	else:
		velocity = Vector2(0,0)
	
	move_and_slide()

func handle_gravity(delta:float)->void:
	velocity.y += gravity * delta

func _process(delta:float)->void:
	handle_animation()
	

func handle_animation()->void:
	if velocity.y < 0:
		animated_sprite.play("fly")
	else:
		animated_sprite.play("down")
	
func handle_input()->void:
	if Input.is_action_just_pressed("fly"):
		fly_up()

func fly_up()->void:
	velocity.y = -forceUp

func die()->void:
	animated_sprite.stop()
	is_die = true
	died.emit()
	
func handle_rotation(delta):
	# Calculate the desired rotation angle based on velocity.y
	var target_angle = 0
	if velocity.y > 0:
		target_angle = max_rotation
	elif velocity.y < 0:
		target_angle = -max_rotation

	var new_rotation = lerpf(rotation_degrees, target_angle, rotation_speed * delta)
	
	# Apply the new rotation to the Sprite node
	rotation_degrees = new_rotation

func _on_game_start()->void:
	is_game_start = true
	fly_up()
