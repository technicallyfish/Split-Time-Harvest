extends CanvasLayer

const dates = {["00","00","0000"]: "intro", ["10", "22", "4004"]: "level_1", ["01", "19", "2089"]: "level_2", ["11", "15", "2026"]: "outro"}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%DateLabel.text = "%s/%s/%s" % Global.current_date


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _open_time_machine() -> void:
	%PopupPanel.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	%Incorrect.visible = false
	get_tree().paused = true
	%PopupPanel.popup_centered()
	
	await %PopupPanel.popup_hide
	get_tree().paused = false

func _on_submit_pressed() -> void:
	var day = %DayLine.text
	var month = %MonthLine.text
	var year = %YearLine.text
	var date = [month, day, year]
	
	if date in dates:
		%PopupPanel.hide()
		print(dates[date])
		Global.current_date = date
		%DateLabel.text = "%s/%s/%s" % date
		get_tree().change_scene_to_file("res://%s.tscn" % dates[date])
		%Player._respawn()
	else:
		%Incorrect.visible = true

# does this work yes
func _on_video_stream_player_finished() -> void:
	Global.current_date = ["04", "18", "2393"]
	%DateLabel.text = "%s/%s/%s" % Global.current_date
	get_tree().change_scene_to_file("res://level_1.tscn")
