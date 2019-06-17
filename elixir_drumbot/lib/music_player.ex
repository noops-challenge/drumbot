defmodule Drumbot.MusicPlayer do
  use GenServer

  def start_link(), do: GenServer.start_link(__MODULE__, [], [name: __MODULE__])
  def init(max_time) do
    IO.inspect max_time
    {:ok, {:timer, 10, 0} }
  end

  def assert(), do: GenServer.cast( __MODULE__, {:assert} )

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

  def handle_cast( {:assert}, state) do
    IO.puts "Empezando"
    IO.inspect state
    loop()
    {:noreply, state}
  end

end
