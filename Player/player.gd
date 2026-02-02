class_name Player extends CharacterBody2D

@onready var slash_scene = preload("res://Player/slash.tscn")

@onready var hud : Hud = $"../Camera2D/Hud"
@onready var camera : Camera2D = $"../Camera2D"
@onready var slash_center : Node2D = $SlashCenter
@onready var slash_pos : Marker2D = $SlashCenter/SlashPos
@onready var dash_length : Timer = $Timers/DashLength
@onready var attack_delay : Timer = $Timers/AttackDelay
@onready var inv_frames : Timer = $Timers/InvFrames
@onready var dash_delay : Timer = $Timers/DashDelay
@onready var soul_drain : Timer = $Timers/SoulDrain
@onready var collision : CollisionShape2D = $CollisionShape2D
@onready var hitbox : Area2D = $Hitbox
@onready var hitbox_collision : CollisionShape2D = $Hitbox/CollisionShape2D
@onready var sprite : Sprite2D = $CollisionShape2D/Sprite2D
@onready var dash_particles : CPUParticles2D = $CollisionShape2D/Sprite2D/DashParticles
@onready var damage_particles : CPUParticles2D = $CollisionShape2D/Sprite2D/DamageParticles
@onready var heal_particles : CPUParticles2D = $CollisionShape2D/Sprite2D/HealParticles

const G := Vector2(0, 980)
const SPEED := 250.0
const JUMP_VELOCITY := -600.0

@export_category("Stats")
@export var Health := 5
@export var maxHealth := 5
@export var Damage := 5
@export_category("Abilities")
@export var have_dash := false

var max_soul := 99
var current_soul := 0
var burned_soul := 0

var is_gameplay := true
var active_input := true
var relinquished := false
var in_menu := false

var canAttack := true
var canDash := true
var canFocus := true

var jumping := false
var falling := false
var dashing := false
var attacking := false

var is_invincible := false

var raw_dir := Vector2.ZERO
var move_dir := 0.0
var last_dir := 1.0
var pogo_velocity := Vector2.ZERO
var current_speed := 0.0
var damage_velocity := Vector2.ZERO
