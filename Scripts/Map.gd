extends CanvasLayer


var mouse_enter = false
var destination = ""


func _unhandled_input(event):
	if mouse_enter == true and Input.is_action_just_pressed("Left Click"):
		get_tree().change_scene("res://Scenes/%s.tscn" %destination)




func _on_Street_Area_Entered():
	mouse_enter = true
	destination = "Street"


func _on_Street_Area_Exited():
	mouse_enter = false
	destination = ""


func _on_Picnic_Area_Entered():
	mouse_enter = true
	destination = "Picnic"


func _on_Picnic_Area_Exited():
	mouse_enter = false
	destination = ""
