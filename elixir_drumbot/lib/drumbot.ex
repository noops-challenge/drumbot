defmodule Drumbot do
	alias Drumbot.Util
	alias Drumbot.MusicPlayer

	def show_songs(), do: Util.get("/")
	def play_song(song) do
		song_for_play =
		"/#{song}"
		  |> Util.get()
		  |> Util.build_model()
		starter_states = Util.get_starter_states(song_for_play)
		_ = MusicPlayer.start_link({0, 0, song_for_play, starter_states})
		MusicPlayer.play()
	end

end
