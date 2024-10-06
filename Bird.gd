extends CharacterBody2D


const UP = Vector2(0,1)
const MAX_SPEED = 200
const FLAP = 200
const Left = 200
const Right = 200
const GRAVITY = 10

var score = 0
var Wall = preload("res://wall_node.tscn")

func _ready():
	pass

func _physics_process(delta):
	velocity.x += 0
	
	velocity.y += GRAVITY
	if velocity.y > MAX_SPEED:
		velocity.y = MAX_SPEED
	if Input.is_action_just_pressed("Flap"):
		velocity.y = -FLAP
	if Input.is_action_just_pressed("Right"):
		velocity.x = Right
		velocity.y = -FLAP
	if Input.is_action_just_pressed("Left"):
		velocity.y = -FLAP
		velocity.x = -Left
	if Input.is_action_just_pressed("Escape"):
		get_tree().reload_current_scene()
	move_and_slide()
	get_parent().get_parent().get_node("CanvasLayer/RichTextLabel").text = str(score)
	
	
func Wall_spawner():
	var Wall_instance = Wall.instantiate()
	Wall_instance.position = Vector2(600, randf_range(-60,60))
	get_parent().call_deferred("add_child", Wall_instance)


func _on_resetter_body_entered(body):
	if body.name == "Wall":
		body.queue_free()
		Wall_spawner()


func _on_detect_area_entered(area):
	if area.name == "PointArea2D":
		score += 1 
		

func _on_detect_body_entered(body):
	if body.name == "Wall":
		get_tree().reload_current_scene()
		
