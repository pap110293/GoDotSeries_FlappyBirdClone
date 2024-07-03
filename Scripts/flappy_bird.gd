extends CharacterBody2D

@export var forceUp:float = 300
@export var max_rorate_up = 45  # Maximum rotation angle in degrees
@export var max_rorate_down = -45  # Maximum rotation angle in degrees
@export var rotation_speed = 5  # Speed of rotation adjustment

@onready var animated_sprite = $AnimatedSprite2D
@onready var audio_manager = $AudioManager

enum AUDIO {POINT, DIE, HIT, WING}
const POINT = preload("res://Assets/Audio/point.ogg")
const DIE = preload("res://Assets/Audio/die.ogg")
const HIT = preload("res://Assets/Audio/hit.ogg")
const WING = preload("res://Assets/Audio/wing.ogg")
const audio_streams:Dictionary = {AUDIO.POINT:POINT, AUDIO.DIE:DIE, AUDIO.HIT:HIT, AUDIO.WING:WING}

signal died

var is_die:bool = false
var is_game_start:bool = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	audio_manager.add_stream(str(AUDIO.POINT), audio_streams[AUDIO.POINT])
	audio_manager.add_stream(str(AUDIO.DIE), audio_streams[AUDIO.DIE])
	audio_manager.add_stream(str(AUDIO.HIT), audio_streams[AUDIO.HIT])
	audio_manager.add_stream(str(AUDIO.WING), audio_streams[AUDIO.WING])
	%GameManager.game_start.connect(_on_game_start)

func _physics_process(delta:float):
	handle_movement(delta)
	
func handle_movement(delta:float)->void:
	if !is_die and is_game_start:
		handle_gravity(delta)
		handle_rotation(delta)
		handle_input()
		handle_animation()
	else:
		velocity = Vector2(0,0)
	
	move_and_slide()

func handle_gravity(delta:float)->void:
	velocity.y += gravity * delta

func handle_animation()->void:
	if velocity.y < 0:
		animated_sprite.play("fly")
	elif velocity.y > 50:
		animated_sprite.play("down")
	
func handle_input()->void:
	if Input.is_action_just_pressed("fly"):
		fly_up()

func fly_up()->void:
	audio_manager.play_stream(str(AUDIO.WING))
	velocity.y = -forceUp

func die()->void:
	animated_sprite.stop()
	is_die = true
	audio_manager.play_stream(str(AUDIO.HIT))
	died.emit()
	
func handle_rotation(delta):
	# Calculate the desired rotation angle based on velocity.y
	var target_angle = 0
	if velocity.y > 300:
		target_angle = max_rorate_up
	elif velocity.y < 0:
		target_angle = max_rorate_down

	var new_rotation = lerpf(rotation_degrees, target_angle, rotation_speed * delta)
	
	# Apply the new rotation to the Sprite node
	rotation_degrees = new_rotation

func _on_game_start()->void:
	is_game_start = true
	fly_up()
	
func add_score(added_score:int)->void:
	%ScoreManager.add_score(added_score)
