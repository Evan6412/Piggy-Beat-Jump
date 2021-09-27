extends KinematicBody2D

const type = "player"
const Speed = 180
const Gravity = 12
const Jumping = -300
const Accel = 14
const Floor = Vector2(0, -1)

#Velocity is the vectors of X and Y axis
var velocity = Vector2()
var on_ground = false
var face_right = true
var JumpNumber = 2

#For Wall Jumping
var WallJump = 850
var JumpWall = 30

"""Movement of the Player"""
func ready(_delta):
	_physics_process(_delta)
	nextToWall()
	nextToRightWall()
	nextToLeftWall()

#Player controls
func _physics_process(_delta):
	
	if face_right == true:
		$Sprite.scale.x = 1
	else:
		$Sprite.scale.x = -1
	#Momentum
	velocity.x = clamp(velocity.x, -Speed, Speed)
	
	#Player moving left and right
	if Input.is_action_pressed("ui_right"):
		velocity.x += Accel
		face_right = true
		$AnimationPlayer.play("run")
	elif Input.is_action_pressed("ui_left"):
		velocity.x -= Accel
		face_right = false
		$AnimationPlayer.play("run")
	
	#Standing still or idle animation
	else:
		velocity.x = lerp(velocity.x, 0, 0.2)
		if on_ground == true:
			$AnimationPlayer.play("Idle")
		
	#Player jumping and WALL JUMPING
	if Input.is_action_just_pressed("ui_up") and JumpNumber > 0:
		if on_ground == true:
			velocity.y = Jumping
			JumpNumber -=1
			on_ground = false
			if !is_on_floor() and nextToRightWall():
				velocity.x -= WallJump 
				velocity.y -= JumpWall 
			elif !is_on_floor() and nextToLeftWall():
				velocity.x += WallJump 
				velocity.y -= JumpWall 
		if nextToWall() and velocity.y > Gravity:
			velocity.y = Gravity
			
	#velocity on the Y axis is adding itself with Gravity and equaling to it
	velocity.y += Gravity
	
	#tells if the player is on the ground, then it can jump. 
	#If not on the ground, then you can't press the jump button again while mid air
	if is_on_floor() or nextToWall():
		JumpNumber = 2
		on_ground = true
	else:
		on_ground = false
	
	#jump and falling animation
	if !is_on_floor():
		if velocity.y < 0:
			$AnimationPlayer.play("jump")
		elif velocity.y > 0:
			$AnimationPlayer.play("fall")
		
	velocity = move_and_slide(velocity, Floor)

#Wall Jumping Stuff
func nextToWall():
	return nextToRightWall() or nextToLeftWall()
	
func nextToRightWall():
	return $Rightwall.is_colliding()
	
func nextToLeftWall():
	return $Leftwall.is_colliding()
