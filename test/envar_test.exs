defmodule EnvarTest do
  use ExUnit.Case
  doctest Envar

  test "Envar.get/1 HELLO returns \"world\"" do
    System.put_env("HELLO", "world")
    assert Envar.get("HELLO") == "world"
  end

  test "Envar.get/1 UNSET returns nil" do
    assert Envar.get("UNSET") == nil
  end

  test "Envar.is_set? UNSET returns false" do
    assert Envar.is_set?("UNSET") == false
  end
end
