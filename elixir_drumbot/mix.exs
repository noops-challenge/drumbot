defmodule Drumbot.MixProject do
  use Mix.Project

  def project do
    [
      app: :drumbot,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 1.0", override: true},
			{:poison, "~> 3.1"},
			{:membrane_core, "~> 0.3.0"},
			{:membrane_element_file, "~> 0.2.3"},
			{:membrane_element_portaudio, "~> 0.2.3"},
			{:membrane_element_ffmpeg_swresample, "~> 0.2.3"},
			{:membrane_element_mad, "~> 0.2.3"}
    ]
  end
end
