extends Node


var mouse_norm = load("res://Textures/Cursor1.png")
var mouse_click = load("res://Textures/Cursor2.png")
var Map = preload("res://Scenes/Map.tscn")

var Data = {
	"Collected Objects": [],
	"Unlocked_Doors": {
		"Basement Door": false
	}
}

var Game_Objects = ["Bear", "Camera", "Basement Key"]

# Called when the node enters the scene tree for the first time.
func _ready():
	copy_objects()
	load_data()


func save_data():
	var f = File.new()
	f.open("user://Data.dat", f.WRITE)
	f.store_line(to_json(Data))
	f.close()


func load_data():
	var f = File.new()
	if f.file_exists("user://Data.dat"):
		f.open("user://Data.dat", f.READ)
		Data = parse_json(f.get_as_text())
		f.close()


func copy_objects():
	var dir = Directory.new()
	if dir.open("user://") == OK:
		dir.make_dir("user://Objects")
		for obj in Game_Objects:
			dir.copy("res://Textures/%s.png" %obj, "user://Objects/%s.png" %obj)




