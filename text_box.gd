extends Node2D

var speaker = 'test'
var text = ['line 1','line that needs to be very very very long ','//text test', 'extra line here for fun']
# use //text <answer> for a textbox question

var line = 0
var i = 0
var finished = false
var ans

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%SpeakerName.text = speaker
	%CloseButton.visible = false
	$LineEdit.visible = false
	$SubmitButton.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if finished: return
	var cur_line = text[line]
	if cur_line.substr(0,6) == '//text':
		$LineEdit.visible = true
		$SubmitButton.visible = true
		ans = cur_line.substr(7, -1)
		#print(ans)
	else:
		%Dialogue.text = cur_line.substr(0,i)
		if i <= len(cur_line) * 1.2 + 14: 
			i += delta * 20
		else:
			line += 1
			if line == len(text):
				finished = true
				%CloseButton.visible = true
			i = 0


func _on_close() -> void:
	get_tree().paused = false
	queue_free()


func _on_submit_button_pressed() -> void:
	var guess = $LineEdit.text
	$SubmitButton.visible = false
	$LineEdit.visible = false
	# replaces the current line to update (keeps current progress + later lines)
	if guess == ans:
		text[line] = "That's correct!"
	else:
		text[line] = "Not quite."
		text.resize(line + 1)
