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
			duration: song["beatsPerMinute"],
			tracks: song["tracks"]
		}
	end

end
