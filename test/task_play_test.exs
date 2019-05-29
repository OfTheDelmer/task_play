defmodule TaskPlayTest do
  use ExUnit.Case
  doctest TaskPlay

  test "greets the world" do
    assert TaskPlay.hello() == :world
  end
end
