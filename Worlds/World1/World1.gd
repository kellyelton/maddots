extends Node2D

export var map_rect := Rect2(0, 0, 500, 500)

export var green_speed := 10
export var red_speed := 5

var points = []

var lines = []

func _ready():
	randomize()
	var screen_count = OS.get_screen_count()
	
	if screen_count == 1: return
	
	var position = OS.get_screen_position(0)
	var size = OS.get_screen_size(0)
	
	OS.window_size = size
	OS.window_position = position
	#OS.window_fullscreen = true
	
	for i in range(0, 80):
		var point = load("res://Components/Points/RedPoint.tscn").instance()
		
		point.position = get_random_position()
		points.append(point)
		$PointLayer.add_child(point)
	for i in range(0, 80):
		var point = load("res://Components/Points/GreenPoint.tscn").instance()
		
		point.position = get_random_position()
		points.append(point)
		$PointLayer.add_child(point)
	for i in range(0, 40):
		var point = load("res://Components/Points/YellowPoint.tscn").instance()
		
		point.position = get_random_position()
		points.append(point)
		$PointLayer.add_child(point)	
	$LineLayer/LineTimer.start()

func _physics_process(delta):
	for point in points:
		var adjusted = bounce_off_map_walls(point.position, point.velocity)
		point.position = adjusted[0]
		point.velocity = adjusted[1]
	update()

func _draw():
	draw_rect(map_rect, Color.midnightblue)

func get_random_position():
	return Vector2(rand_range(0, map_rect.size.x), rand_range(0, map_rect.size.y))

func get_random_left_position():
	return Vector2(rand_range(0, map_rect.size.x / 2), rand_range(0, map_rect.size.y))

func get_random_right_position():
	return Vector2(rand_range(map_rect.size.x / 2, map_rect.size.x), rand_range(0, map_rect.size.y))

func get_random_velocity():
	return Vector2((randf() * 2) - 1, (randf() * 2) - 1)

func bounce_off_map_walls(point: Vector2, velocity: Vector2) -> Array:
	if point.x > map_rect.size.x:
		point.x = map_rect.size.x
		velocity.x = -velocity.x
	if point.y > map_rect.size.y:
		point.y = map_rect.size.y
		velocity.y = -velocity.y
	if point.x < 0:
		point.x = 0
		velocity.x = -velocity.x
	if point.y < 0:
		point.y = 0
		velocity.y = -velocity.y
	
	return [point, velocity]


func _on_LineTimer_timeout():
	$LineLayer.lines.clear()

	for point in points:
		for line in point.lines:
			$LineLayer.lines.append([line[0], line[1], point.color])
	
	$LineLayer.update()
