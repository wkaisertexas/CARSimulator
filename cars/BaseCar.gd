extends VehicleBody3D



@export var STEER_SPEED = 1.5
@export var STEER_LIMIT = 0.6
var steer_target = 0
@export var engine_force_value = 40
@export var spline : Path3D
@export var closest_point_indicator: MeshInstance3D
@export var user_control : bool = false


var file : FileAccess
func _ready():
	# opening up a file
	file = FileAccess.open("./experiment_data.csv", FileAccess.WRITE)
	file.store_line("Time,HInput,VInput,Distance,Position")

func _physics_process(delta):
	# custom codeex
	var curve = spline.get_curve()
	
	# nearest point
	var origin = transform.origin
	var point = curve.get_closest_point(origin)
	closest_point_indicator.transform.origin = point
	
	# offset vector
	var offset = (origin - point)
	var offset_length = offset.length()
	offset = offset.normalized()
	var offset_angle = atan2(offset.z, offset.x)
	
	var t = curve.get_closest_offset(transform.origin)
	
	var b_tan = curve.sample_baked(t)
	var a_tan = curve.sample_baked(t + 0.001)
	var tangent = (b_tan - a_tan).normalized()	
	print(tangent)
	var tangent_angle = atan2(tangent.z, tangent.x)
	
	# finding my current position
	var orthonormalized_rotation = transform.orthonormalized().basis
	
	var rel_weight = 0.5
	var target_angle = rel_weight * tangent_angle + (1 - rel_weight) * offset_angle
	
	# goal: to have the forward vector minus the offset equal the tangent vector
	var diff = cos(rotation.y - target_angle)
	
	# let normal
	var normal = offset.cross(tangent).cross(global_transform.basis.x)
	
	if normal.x < 0:
		print(normal)
		steer_target = -0.05 * offset_length
	else: 
		print(normal)
		steer_target = 0.05 * offset_length
		
	print("forward", global_transform.basis.x)
	
	#steer_target = diff
	file.store_line("%i, %f, %f, %f" % [Time.get_ticks_msec(), steer_target, 1.0, offset_length])

	# already there code
	var speed = linear_velocity.length()*Engine.get_frames_per_second()*delta
	traction(speed)
	$Hud/speed.text=str(round(speed*3.8))+"  KMPH"

	var fwd_mps = transform.basis.x.x
	
	if user_control:
		steer_target = Input.get_action_strength("ui_left") - Input.get_action_strength("ui_right")
	steer_target *= STEER_LIMIT
	 
	if Input.is_action_pressed("ui_down"):
		user_control = !user_control
	
	if Input.is_action_pressed("ui_down"):
	# Increase engine force at low speeds to make the initial acceleration faster.

		if speed < 20 and speed != 0:
			engine_force = clamp(engine_force_value * 3 / speed, 0, 300)
		else:
			engine_force = engine_force_value
	else:
		engine_force = 0
	if Input.is_action_pressed("ui_up"):
		# Increase engine force at low speeds to make the initial acceleration faster.
		if fwd_mps >= -1:
			if speed < 30 and speed != 0:
				engine_force = -clamp(engine_force_value * 10 / speed, 0, 300)
			else:
				engine_force = -engine_force_value
		else:
			brake = 1
	else:
		brake = 0.0
		
	if Input.is_action_pressed("ui_select"):
		brake=3
		$wheal2.wheel_friction_slip=0.8
		$wheal3.wheel_friction_slip=0.8
	else:
		$wheal2.wheel_friction_slip=3
		$wheal3.wheel_friction_slip=3
	steering = move_toward(steering, steer_target, STEER_SPEED * delta)

func _exit_tree():
	file.close()

func traction(speed):
	apply_central_force(Vector3.DOWN*speed)




