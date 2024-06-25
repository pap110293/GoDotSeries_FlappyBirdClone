extends CharacterBody2D

@export var forceUp:float = 300
@export var max_rotation = 45  # Maximum rotation angle in degrees
@export var rotation_speed = 5  # Speed of rotation adjustment

@onready var animated_sprite = $AnimatedSprite2D
@onready var collision_polygon = $CollisionPolygon2D

signal died

var is_die:bool = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta:float)->void:
	
	if !is_die:
		handle_gravity(delta)
		handle_rotation(delta)
		handle_input()
	else:
		collision_polygon.disabled = true
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

	# TODO: need to calculate the angle while up and down
	var new_rotation = lerpf(animated_sprite.rotation_degrees, target_angle, rotation_speed * delta)
	
	# Apply the new rotation to the Sprite node
	animated_sprite.rotation_degrees = new_rotation
