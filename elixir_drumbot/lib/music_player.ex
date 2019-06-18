defmodule Drumbot.MusicPlayer do
  use GenServer

  #{:timer, 10, 0}
  def start_link(state \\ []), do: GenServer.start_link(__MODULE__, state, name: __MODULE__)
	def init(state), do: {:ok, state}

  def play(), do: GenServer.cast( __MODULE__, {:play} )
  def loop(), do: send self(), :loop

  def handle_info(:loop, state) do
    {:timer, max_time, current} = state
    validate_max_time = fn
      true ->
        IO.puts "DONE!!"
        {:noreply, state}
      false ->
        :timer.sleep 1000
        loop()
        IO.puts "Max time: #{max_time} Seg: #{current}"
        {:noreply, {:timer, max_time, current+1} }
    end
    validate_max_time.(max_time==current)
  end

  def handle_cast( {:play}, state) do
    loop()
    {:noreply, state}
  end

end

