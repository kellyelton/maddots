extends Point

const yellow_attracion: float = -Electromagnetic_Power
const yellow_attraction_distance: float = Electromagnetic_Distance
const red_attracion: float = 0.0
const red_attraction_distance: float = 1.0
const green_attracion: float = Electromagnetic_Power
const green_attraction_distance: float = Electromagnetic_Distance

func _init():
	self.type = "yellow"
	self.color = Color.yellow

func _interact_with_yellow(other, delta) -> Vector2:
	var distance = self.position.distance_to(other.position)
	
	if distance == 0: return Vector2.ZERO
	if distance > yellow_attraction_distance: return Vector2.ZERO
	
	var direction = self.position.direction_to(other.position)
	
	var speed = (1 / distance) * yellow_attracion
	
	var vel_boost = direction * speed
	
	#self.lines.append([self.global_position, other.global_position])
	
	return vel_boost

func _interact_with_green(other, delta) -> Vector2:
	var distance = self.position.distance_to(other.position)
	
	if distance == 0: return Vector2.ZERO
	if distance > green_attraction_distance: return Vector2.ZERO
	
	var direction = self.position.direction_to(other.position)
	
	var speed: float = 0
	if distance < 3:
		speed = 0#((1 / distance) * green_attracion) * -2
	else:
		speed = (1 / distance) * green_attracion
	
	var vel_boost = direction * speed
	
	#self.lines.append([self.global_position, other.global_position])
	
	return vel_boost

func _interact_with_red(other, delta) -> Vector2:
	var distance = self.position.distance_to(other.position)
	
	if distance == 0: return Vector2.ZERO
	if distance > red_attraction_distance: return Vector2.ZERO
	
	var direction = self.position.direction_to(other.position)
	
	var speed: float = 0
	if distance < 5:
		speed = ((1 / distance) * red_attracion) * -2
	else:
		speed = (1 / distance) * red_attracion
	
	var vel_boost = direction * speed
	
	#self.lines.append([self.global_position, other.global_position])
	
	return vel_boost
