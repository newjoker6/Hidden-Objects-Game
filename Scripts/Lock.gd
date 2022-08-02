extends Sprite


var mouse_enter = false
export var needed_key: String
export var door: String
export var unlock_image: String
var tex

signal unlocked

# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.connect("mouse_entered", self, "_mouse_entered")
	$Area2D.connect("mouse_exited", self, "_mouse_exited")
	check_unlock(door)

func _mouse_entered():
	Input.set_custom_mouse_cursor(Global.mouse_click)
	mouse_enter = true


func _mouse_exited():
	Input.set_custom_mouse_cursor(Global.mouse_norm)
	mouse_enter = false

func _unhandled_input(event):
	if Input.is_action_just_pressed("Left Click") and mouse_enter == true:
		if get_parent().item_selected == needed_key and Global.Data["Unlocked_Doors"][door] == false:
			unlock(needed_key)

func unlock(key):
	emit_signal("unlocked", key)
	Global.Data["Unlocked_Doors"][door] = true
	Global.save_data()
	if unlock_image == "":
		self.queue_free()
	else:
		create_texture(unlock_image)
		self.texture = tex
#	self.queue_free()


func check_unlock(door):
	if Global.Data["Unlocked_Doors"][door] == true:
		self.queue_free()


func create_texture(obj):
	var img = Image.new()
	img.load(obj)
	tex = ImageTexture.new()
	tex.create_from_image(img)










