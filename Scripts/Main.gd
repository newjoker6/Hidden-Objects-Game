extends Node2D


var i = 0
var tex
var item_selected = ""
var map_display = false



# Called when the node enters the scene tree for the first time.
func _ready():
	add_collected_to_list()
	replace_spaces_in_object()
	remove_keys_from_scene()
	connect_signals()
#	OS.shell_open(OS.get_user_data_dir())


func create_texture(obj):
	var img = Image.new()
	img.load("user://Objects/%s.png" %obj)
	tex = ImageTexture.new()
	tex.create_from_image(img)



func connect_signals():
	$ItemList.connect("item_selected", self, "on_item_selected")
	$ItemList.connect("nothing_selected", self, "on_nothing_selected")
	for child in self.get_children():
		if "Lock" in child.name:
			$Lock.connect("unlocked", self, "remove_key")


func remove_key(key):
	var key_index = $ItemList.get_selected_items()
	$ItemList.remove_item(key_index[0])
	Global.Data["Collected Objects"].erase(item_selected)
	on_nothing_selected()

func on_item_selected(idx):
	item_selected = $ItemList.get_item_text(idx)
	print(item_selected)
	if !"Key" in item_selected:
		$ItemList.unselect_all()



func on_nothing_selected():
	$ItemList.unselect_all()
	item_selected = ""


func add_collected_to_list():
#	while i < Global.Data["Collected Objects"].size():
#		create_texture(Global.Data["Collected Objects"][i])
#		get_node("ItemList").add_item(Global.Data["Collected Objects"][i].capitalize(), tex)
#		i += 1
	
	for obj in Global.Data["Collected Objects"]:
		create_texture(obj)
		get_node("ItemList").add_item(obj.capitalize(), tex)


func replace_spaces_in_object():
	if Global.Data["Collected Objects"]:
		for item in Global.Data["Collected Objects"]:
			if " " in item:
				item = item.replace(" ", "")
			remove_item_from_scene(item)


func remove_item_from_scene(item):
	for child in self.get_children():
		if item == child.name:
			get_node("./%s" %item).queue_free()


func remove_keys_from_scene():
	for door in Global.Data["Unlocked_Doors"]:
		if Global.Data["Unlocked_Doors"][door] == true:
			var key
			key = door.replace(" ", "")
			key = key.replace("Door", "Key")
			remove_item_from_scene(key)


func _unhandled_input(event):
	if Input.is_action_just_pressed("Map"):
		if map_display == false:
			map_display = true
			var inst_map = Global.Map.instance()
			add_child(inst_map)
		else:
			map_display = false
			for child in self.get_children():
				if child.name == "Map":
					get_node(child.name).queue_free()



