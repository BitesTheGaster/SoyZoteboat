class_name Enemy extends CharacterBody2D

@onready var leg : Sprite2D = $Sprite/Leg
@onready var leg2 : Sprite2D = $Sprite/Leg2
@onready var sprite : Sprite2D = $Sprite/Head
@onready var hitbox : Area2D = $Hitbox
@onready var right : Area2D = $Checks/Right
@onready var left : Area2D = $Checks/Left
@onready var chase_range : Area2D = $Checks/ChaseRange
@onready var inv_frames : Timer = $InvFrames

const IDLE_SPEED = 100.0
const CHASE_SPEED = 200.0
const KNOCKBACK_MULTIPLIER = 1.0
const G = Vector2(0, 980)

var is_invincible := false

var move_dir := 0.0

var knockback := Vector2.ZERO
var health := 15
var taken_damage := 0
