extends CharacterBody2D

@export var forceUp:float = 300
@onready var bottom_ray_cast = $BottomRayCast
@onready var front_ray_cast = $FrontRayCast

var is_die:bool = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta:float)->void:
	if !is_die:
		handle_gravity(delta)
		handle_input()
	else:
		velocity.y = 0
		
	move_and_slide()

func handle_gravity(delta:float)->void:
	velocity.y += gravity * delta

func _process(delta:float)->void:
	pass
	
func handle_input()->void:
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = -forceUp

func die()->void:
	is_die = true
	print_debug("you die")
