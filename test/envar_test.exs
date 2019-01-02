defmodule EnvarTest do
  use ExUnit.Case
  doctest Envar

  test "greets the world" do
    assert Envar.hello() == :world
  end
end
