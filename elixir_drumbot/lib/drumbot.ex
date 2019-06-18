defmodule Drumbot do
	alias Drumbot.Util

	def show_songs(), do: Util.get("/")
	def play_song(song) do
		"/#{song}"
			|> Util.get()
			|> Util.build_model()
	end

end
