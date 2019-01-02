defmodule EnvarTest do
  use ExUnit.Case
  doctest Envar

  test "Envar.get USER returns the USER" do
    System.put_env("HELLO", "world")
    assert Envar.get("HELLO") == "world"
  end

  test "Envar.get UNSET returns nil" do
    assert Envar.get("UNSET") == nil
  end
end
