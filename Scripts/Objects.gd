extends Sprite


var mouse_enter = false
var clickable = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.connect("mouse_entered", self, "_mouse_entered")
	$Area2D.connect("mouse_exited", self, "_mouse_exited")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !$Area2D.get_overlapping_areas():
		clickable = true


func _mouse_entered():
	Input.set_custom_mouse_cursor(Global.mouse_click)
	mouse_enter = true


func _mouse_exited():
	Input.set_custom_mouse_cursor(Global.mouse_norm)
	mouse_enter = false


func _unhandled_input(_event):
	if Input.is_action_just_pressed("Left Click") and mouse_enter == true and clickable == true:
		get_parent().get_node("ItemList").add_item(self.name.capitalize(), self.texture)
		Global.Data["Collected Objects"].append(self.name.capitalize())
		_mouse_exited()
		print(Global.Data["Collected Objects"])
		Global.save_data()
		self.queue_free()
