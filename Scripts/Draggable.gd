extends Sprite


var mouse_enter
var following = false
var start_position: Vector2
export var drag_distance: int


# Called when the node enters the scene tree for the first time.
func _ready():
	start_position = self.position
	$Area2D.connect("mouse_entered", self, "_mouse_entered")
	$Area2D.connect("mouse_exited", self, "_mouse_exited")


func _mouse_entered():
	Input.set_custom_mouse_cursor(Global.mouse_click)
	mouse_enter = true


func _mouse_exited():
	Input.set_custom_mouse_cursor(Global.mouse_norm)
	mouse_enter = false


func _unhandled_input(event):
	if Input.is_mouse_button_pressed(1) and mouse_enter == true:
		following = true
	if !Input.is_mouse_button_pressed(1) and mouse_enter == true:
		following = false

func _process(delta):
	if following == true:
		if self.position.distance_to(start_position) >= drag_distance:
			following = false
		else:
			self.set_position(get_global_mouse_position())
