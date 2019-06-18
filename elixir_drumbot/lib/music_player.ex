defmodule Drumbot.MusicPlayer do
  use GenServer

  def start_link(state \\ []), do: GenServer.start_link(__MODULE__, state, name: __MODULE__)
	def init(state), do: {:ok, state}

  def play(), do: GenServer.cast( __MODULE__, {:play} )
  def loop(), do: send self(), :loop

  def handle_info(:loop, state) do
		{current, current_index, song, previous_tracks_states} = state
    validate_max_time = fn
      true ->
        IO.puts "Song Finished!!!!"
        {:noreply, state}
      false ->
        :timer.sleep 1000
        loop()
				index = get_index(current_index, song.steps)
				tracks_to_play = play_tracks(index, song.tracks)
				next_tracks_states = for {_instrument, track_state} <- tracks_to_play, do: track_state
				#IO.puts "Previous states: "
				#IO.inspect previous_tracks_states
				#IO.puts "Next states: "
				#IO.inspect next_tracks_states
				IO.puts "[#{current}]/[#{song.duration}]"
				p = play_sound(previous_tracks_states, tracks_to_play)
				IO.inspect p
        {:noreply, {current+1, index+1, song, next_tracks_states}}
    end
    validate_max_time.(song.duration==current)
  end

	def play_sound(previous_states, tracks_to_play) do
		tracks = Enum.zip(previous_states, tracks_to_play)
		for {previous_state, {instrument, next_state}} <- tracks do
			turn_on = fn
				{0,1} -> {:turn_on, instrument}
				{1,0} -> {:turn_off, instrument}
				_ -> {:continue, instrument}
			end
			turn_on.({previous_state, next_state})
		end
	end

  def handle_cast( {:play}, state) do
    loop()
    {:noreply, state}
  end

	defp get_index(current, max_steps) do
		loop_index = fn
			true -> current
			false -> 0
		end
		loop_index.(current<max_steps)
	end

	defp play_tracks(index, tracks) do
		for %{"instrument" => instrument, "steps" => steps} <- tracks do
			current_note = Enum.at(steps, index)
			{instrument, current_note}
		end
	end

end

