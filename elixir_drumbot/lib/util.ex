defmodule Drumbot.Util do
	alias Drumbot.Song

  @base_url "https://api.noopschallenge.com/drumbot/patterns"
  @instruments ["A.mp3", "B.mp3", "C.mp3", "E.mp3", "D.mp3"]

  def get(uri) do
    {:ok, response} = HTTPoison.get("#{@base_url}#{uri}")
    Poison.decode!(response.body)
  end

	def build_model(song) do
		tracks = replace_instruments(song["tracks"])
		%Song{
			name: song["name"],
			steps: song["stepCount"],
			duration: song["beatsPerMinute"],
			tracks: tracks
		}
	end

	def replace_instruments(tracks) do
		new_tracks = Enum.zip(tracks, @instruments)
		for {%{"instrument" => _instrument, "steps" => steps}, instrument} <- new_tracks do
			%{"instrument" => instrument, "steps" => steps}
		end
	end

	def get_starter_states(song) do
		states = length(song.tracks)-1
		Enum.map(0..states, fn _x -> 0 end)
	end

end
