defmodule Drumbot.Pipeline do
  use Membrane.Pipeline

  def handle_init(path_to_mp3) do
    children = [
      file_src: %Membrane.Element.File.Source{location: path_to_mp3},
      decoder: Membrane.Element.Mad.Decoder,
      converter: %Membrane.Element.FFmpeg.SWResample.Converter{output_caps: %Membrane.Caps.Audio.Raw{sample_rate: 48000, format: :s16le, channels: 2}},
      sink: Membrane.Element.PortAudio.Sink,
    ]

    links = %{
      {:file_src, :output} => {:decoder, :input},
      {:decoder, :output} => {:converter, :input},
      {:converter, :output} => {:sink, :input}
    }

    spec = %Membrane.Pipeline.Spec{
      children: children,
      links: links
    }

    {{:ok, spec}, %{}}
  end

end
