defmodule Drumbot.Util do

  @base_url "https://api.noopschallenge.com/drumbot/patterns"

  def get(uri) do
    {:ok, response} = HTTPoison.get("#{@base_url}#{uri}")
    Poison.decode!(response.body)
  end

end
