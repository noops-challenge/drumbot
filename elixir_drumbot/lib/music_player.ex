defmodule Drumbot.MusicPlayer do
  use GenServer

  def start_link(), do: GenServer.start_link(__MODULE__, [], [name: __MODULE__])
  def init(_), do: {:ok, {:general_score, 0} }

  def assert(), do: GenServer.cast( __MODULE__, {:assert} )
  def fail(), do: GenServer.cast( __MODULE__, {:fail} )

  def handle_cast( {:assert}, state) do
    {_, score} = state
    next_score = score+1
    IO.puts "Score: #{next_score}"
    {:noreply, {:general_score, next_score} }
  end

  def handle_cast( {:fail}, state) do
    {_, score} = state
    next_score = decrement_score( score )
    IO.puts "Score: #{next_score}"
    {:noreply, {:general_score, next_score} }
  end

  def decrement_score( 0 ), do: 0
  def decrement_score( score ), do: score-1

end
