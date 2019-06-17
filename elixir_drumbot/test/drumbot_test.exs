defmodule DrumbotTest do
  use ExUnit.Case
  doctest Drumbot

  test "greets the world" do
    assert Drumbot.hello() == :world
  end
end
