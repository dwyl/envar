defmodule Envar do
  @moduledoc """
  Docs for `Envar`; Environment Variable checker/getter.
  Variable names are logged to improve developer experience.
  The _values_ of Environment Variables should _never_ be logged here.
  If an App needs to debug a variable, it can log it locally.

  """

  require Logger

  @doc """
  `get/1` gets an environment variable by name 
  e.g: `Envar.get("DATABASE_URL")`
  Either returns the `String` value of the environment variable,
  or `nil` if the value is not set.
  When the environment variable is not defined,
  this will be logged for debugging purposes.

  ## Examples

      iex> System.put_env("HELLO", "world")
      iex> Envar.get("HELLO")
      "world"

  """
  def get(varname) do
    case System.get_env(varname) do
      nil ->
        Logger.error("ERROR: #{varname} Environment Variable is not set")
        nil
      val ->
        # IO.inspect(val, label: "val")
        val
    end
  end

  @doc """
  `is_set/1` binary check that an environment variable is defined by name 
  e.g: `Envar.is_set?("HEROKU")` will return `false`
  if the `HEROKU` environment variable is not set.
  When a particular variable is set, it will return `true`.

  ## Examples
      iex> Envar.is_set?("HEROKU")
      false

      iex> System.put_env("HELLO", "world")
      iex> Envar.is_set?("HELLO")
      true

  """
  def is_set?(varname) do
    case System.get_env(varname) do
      nil ->
        Logger.debug("#{varname} Environment Variable is not set")
        false
      _ ->
        true
    end
  end

  @doc """
  `is_set_any/1` binary check that any 
  environment variable in a `List` is defined.
  e.g: `Envar.is_set?(["HEROKU", "FLYIO"])` will return `false`
  if _both_ the `HEROKU` and `FLYIO` environment variables are _not_ set.
  When any of the environment variables in the list are set, 
  it will return `true`.
  It's the equivalent of writing:
  `Envar.is_set?("HEROKU") || Envar.is_set?("FLYIO")`.

  ## Examples
      iex> Envar.is_set_any?(["HEROKU", "AWS"])
      false

      iex> System.put_env("HELLO", "world")
      iex> Envar.is_set_any?(["HELLO",  "GOODBYE"])
      true

  """
  def is_set_any?(list) do
    Enum.any?(list, fn var -> is_set?(var) end)
  end
end
