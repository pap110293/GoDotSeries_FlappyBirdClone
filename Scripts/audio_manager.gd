extends Node

var audio_streams:Dictionary

func add_stream(streamName:String, source:Resource):
	var audio_stream = audio_streams.get(streamName)
	
	if audio_stream:
		audio_stream.stream = source
	else:
		audio_streams[streamName] = create_audio_player(streamName, source)

func create_audio_player(streamName:String, source:Resource)->AudioStreamPlayer2D:
	var audio_stream_player = AudioStreamPlayer2D.new()
	audio_stream_player.name = streamName
	audio_stream_player.stream = source
	add_child(audio_stream_player)
	return audio_stream_player

func remove_audio(streamName:String)->void:
	var child_node = find_child(streamName)
	if(child_node):
		audio_streams.erase(streamName)
		child_node.queue_free()

func play_stream(streamName:String)->void:
	var audio_stream:AudioStreamPlayer2D = audio_streams.get(streamName)
	if audio_stream:
		audio_stream.play()
