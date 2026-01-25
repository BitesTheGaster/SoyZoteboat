class_name Player extends CharacterBody2D

@onready var slash_scene = preload("res://Player/slash.tscn")

@onready var hud : Hud = $"../Camera2D/Hud"
@onready var camera : Camera2D = $"../Camera2D"
@onready var slash_center : Node2D = $SlashCenter
@onready var slash_pos : Marker2D = $SlashCenter/SlashPos
@onready var dash_length : Timer = $Timers/DashLength
@onready var attack_delay : Timer = $Timers/AttackDelay
@onready var inv_frames : Timer = $Timers/InvFrames
@onready var collision : CollisionShape2D = $CollisionShape2D

const G := Vector2(0, 980)
const SPEED := 250.0
const JUMP_VELOCITY := -600.0

@export_category("Stats")
@export var Health := 5
@export var Damage := 5

var is_gameplay := true

var active_input := true
var relinquished := false
var in_menu := false

var canAttack := true
var canDash := true

var jumping := false
var falling := false
var dashing := false
var attacking := false

var is_invincible := false

var raw_dir := Vector2.ZERO
var move_dir := 0.0
var pogo_velocity := Vector2.ZERO
var current_speed := 0.0
