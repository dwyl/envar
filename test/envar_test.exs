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

  test "Envar.is_set_all?(~w/EVERYTHING NOTHING/) returns false" do
    Envar.set("EVERYTHING", "AWESOME!")
    assert Envar.is_set_any?(~w/EVERYTHING NOTHING/) == true
  end

  test "Envar.is_set_all?(~w/EVERYTHING NOTHING/) returns true" do
    Envar.set("EVERYTHING", "AWESOME!")
    System.put_env("HELLO", "world")
    assert Envar.is_set_any?(~w/EVERYTHING HELLO/) == true
  end

  test "Envar.is_set_any?([\"HEROKU\", \"GITHUB\"]) returns false" do
    assert Envar.is_set_any?(["HEROKU", "GITHUB"]) == false
    assert Envar.set("EVERYTHING", "AWESOME!")
    assert Envar.is_set_any?(~w/EVERYTHING NOTHING/) == true
  end

  test "Envar.is_set_any?(~w/EVERYTHING NOTHING/) returns true" do
    Envar.set("EVERYTHING", "AWESOME!")
    assert Envar.is_set_any?(~w/EVERYTHING NOTHING/) == true
  end

  test "Envar.set(\"HELLO\", \"world\") sets the HELLO variable" do
    assert Envar.set("HELLO", "world") == :ok
    assert Envar.get("HELLO") == "world"
  end

  test "Envar.load(\".env\") loads the .env file" do
    assert Envar.load(".env") == :ok
    assert Envar.get("EVERYTHING") == "awesome!"
    assert Envar.get("ADMIN_EMAIL") == "alex@gmail.com"
    # comments and empty lines are ignored in the .env file ✅
    assert Envar.get("SECRET") == "master plan"
  end
end
