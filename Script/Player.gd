extends KinematicBody2D

export(int) var Max_speed = 200
export(int) var Acceleration = 500 # gia toc
export(int) var Friction = 500 #ma sat

enum{
	MOVE,
	PICK,
	DROP,
	EXPLOIT # khai thac
}

var State = MOVE
var Velocity = Vector2.ZERO #  zero <=> (0,0)

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _ready():
	pass
	
func _physics_process(delta):
	Move_state(delta)

func Move_state(delta):
	var Input_Vector = Vector2.ZERO
	Input_Vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	Input_Vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	Input_Vector = Input_Vector.normalized()
	
	if Input_Vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", Input_Vector)
		animationTree.set("parameters/Run/blend_position", Input_Vector)
		animationState.travel("Run")
		Velocity = Velocity.move_toward(Input_Vector*Max_speed,Acceleration*delta)
	else:
		animationState.travel("Idle")
		Velocity = Velocity.move_toward(Vector2.ZERO,Friction*delta)
	Move()
func Move():
	Velocity = move_and_slide(Velocity)
