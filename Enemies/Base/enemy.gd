class_name Enemy extends CharacterBody2D

@onready var rage_sprite : Sprite2D = $Sprite/Rage
@onready var sprite : Sprite2D = $Sprite/Head
@onready var hitbox : Area2D = $Hitbox
@onready var right : Area2D = $Checks/Right
@onready var left : Area2D = $Checks/Left
@onready var chase_range : Area2D = $Checks/ChaseRange
@onready var inv_frames : Timer = $InvFrames
@onready var dash_time : Timer = $DashTime
@onready var dash_delay : Timer = $DashDelay
@onready var dash_anim_delay : Timer = $DashAnimDelay
@onready var dash_particles : CPUParticles2D = $DashParticles


const IDLE_SPEED = 50.0
const CHASE_SPEED = 100.0
const DASH_SPEED = 600.0
const KNOCKBACK_MULTIPLIER = 1.0
const G = Vector2(0, 980)

var is_invincible := false
var is_dashing := false
var move_dir := 0.0
var last_dir := 0.0
var target : Player
var can_go_right := true
var can_go_left := true

var knockback := Vector2.ZERO
var health := 15
var taken_damage := 0
