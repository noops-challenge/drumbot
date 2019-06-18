# Elixir Drumbot

## Installation

1. Install external dependencies

This project is using Membrane for play the mp3 songs, so before to start you have to install some dependencies, check [here](https://membraneframework.org/guide/v0.3/pipeline.html#content)

2. Install elixir dependencies

> mix deps.get

## Usages

Open an iEX `iex -S mix` inside this directory.

### Patterns 

You can see the patterns availables from the Drumbot endpoint

```
Erlang/OTP 21 [erts-10.3.4] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [hipe] [dtrace]

Compiling 1 file (.ex)
Interactive Elixir (1.8.1) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> Drumbot.show_songs
[
  %{"name" => "oontza"},
  %{"name" => "bossanoopa"},
  %{"name" => "nipnop"},
  %{"name" => "botthisway"},
  %{"name" => "funkee"},
  %{"name" => "shlojam"},
  %{"name" => "botorik"},
  %{"name" => "swoop"},
  %{"name" => "schmaltz"},
  %{"name" => "bouncy"}
]
```

### Play a pattern

```
iex(3)> Drumbot.play_song "botorik"
```

