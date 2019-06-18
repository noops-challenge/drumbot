defmodule Drumbot.Util do
	alias Drumbot.Song

  @base_url "https://api.noopschallenge.com/drumbot/patterns"

  def get(uri) do
    {:ok, response} = HTTPoison.get("#{@base_url}#{uri}")
    Poison.decode!(response.body)
  end

	def build_model(song) do
		%Song{
			name: song["name"],
			steps: song["stepCount"],
			duration: song["beatsPerMinute"],
			tracks: song["tracks"]
		}
	end

	def get_starter_states(song) do
		states = length(song.tracks)-1
		Enum.map(0..states, fn _x -> 0 end)
	end

end
