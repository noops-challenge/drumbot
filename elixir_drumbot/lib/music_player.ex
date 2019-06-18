defmodule Drumbot.MusicPlayer do
  use GenServer
	alias Drumbot.Pipeline
  @instruments %{ "B.mp3" => "🎷", "E.mp3" => "🗣", "D.mp3" => "🎺", "C.mp3" => "🎸", "A.mp3" => "🎻"}

  def start_link(state \\ []), do: GenServer.start_link(__MODULE__, state, name: __MODULE__)
	def init(state), do: {:ok, state}

  def play(), do: GenServer.cast( __MODULE__, {:play} )
  def loop(), do: send self(), :loop

  def handle_info(:loop, state) do
		{current, current_index, song, previous_tracks_states} = state
    validate_max_time = fn
      true ->
        IO.puts "Song Finished!!!!"
        Process.exit( self() , :kill)
        {:noreply, state}
      false ->
        :timer.sleep 1000
        IEx.Helpers.clear
        loop()
				index = get_index(current_index, song.steps)
				tracks_to_play = play_tracks(index, song.tracks)
				next_tracks_states = for {_instrument, track_state} <- tracks_to_play, do: track_state
				states_for_monitor = play_sound(previous_tracks_states, tracks_to_play)
        IO.puts "- - - - - - - - - - - - - - - - - - - - - "
        print_dj(current)
				IO.puts "[#{current}]/[#{song.duration}]"
        IO.puts "Made with Elixir"
        IO.puts "\nTracks playing:"
        states_for_monitor |> Bunt.puts
        IO.puts "- - - - - - - - - - - - - - - - - - - - - "
        {:noreply, {current+1, index+1, song, next_tracks_states}}
    end
    validate_max_time.(song.duration==current)
  end

  def print_dj(current) do
    show_dj = fn
      0 ->
        [:color201, "     .:: GitHub Meet the Noobs ::. "] |> Bunt.puts
        [:color201, "     M E E T - T H E - N O O B S \n"] |> Bunt.puts
        [:color154, "######  DJ Drumbot               /#####"] |> Bunt.puts
        [:color154, "#( )# |          _ 🧐__          | #( )#"] |> Bunt.puts
        [:color154, "##### |         /_    /         | #####"] |> Bunt.puts
        [:color154, "#   # |     ___m/I_ //_____     | #   #"] |> Bunt.puts
        [:color154, "# O # |____#-x.\ /++m\ /.x-#____| # O #"] |> Bunt.puts
        [:color154, "#m.m# |   // \ ///###\\\ / /\   | #m.m#"] |> Bunt.puts
        [:color154, "#####/    ######/     \######    \#####"] |> Bunt.puts
      _ ->
        [:color201, "     .:: GitHub Meet the Noobs ::. \n"] |> Bunt.puts
        [:color154, "######  DJ Drumbot     🤘🏻        /######"] |> Bunt.puts
        [:color154, "#( )# |          _ 😌__||       | #( )#"] |> Bunt.puts
        [:color154, "##### |         /_   |          | #####"] |> Bunt.puts
        [:color154, "#   # |     ___m/I_  |_____     | #   #"] |> Bunt.puts
        [:color154, "# O # |____#-x.\ /++m\ /.x-#____| # O #"] |> Bunt.puts
        [:color154, "#m.m# |   // \ ///###\\\ / /\   | #m.m#"] |> Bunt.puts
        [:color154, "#####/    ######/     \######    \#####"] |> Bunt.puts
    end
    show_dj.(rem(current,2))
  end

	def play_sound(previous_states, tracks_to_play) do
		tracks = Enum.zip(previous_states, tracks_to_play)
    monitor_status =
		  for {previous_state, {instrument, next_state}} <- tracks do
		  	turn_on = fn
		  		{0,1} ->
		  			{:ok, pid} = Pipeline.start_link(instrument)
		  			_res = Pipeline.play(pid)
            [:color228, " :: #{@instruments[instrument]} :: "]
		  		{1,0} ->
            [:color198, " ::   :: "]
          _ ->
            [:color198, " ::   :: "]
		  	end
		  	turn_on.({previous_state, next_state})
		  end
    List.flatten(monitor_status)
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

