extends Node

var audio_streams:Dictionary

func add_stream(name:String, source:Resource):
	var audio_stream = audio_streams.get(name)
	
	if audio_stream:
		audio_stream.stream = source
	else:
		audio_streams[name] = create_audio_player(name, source)

func create_audio_player(name:String, source:Resource)->AudioStreamPlayer2D:
	var audio_stream_player = AudioStreamPlayer2D.new()
	audio_stream_player.name = name
	audio_stream_player.stream = source
	add_child(audio_stream_player)
	return audio_stream_player

func remove_audio(name:String)->void:
	var child_node = find_child(name)
	if(child_node):
		audio_streams.erase(name)
		child_node.queue_free()
