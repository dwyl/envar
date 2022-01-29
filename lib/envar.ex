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
  `is_set_all/1` binary check that ***ALL***
  environment variable in a `List` are defined.
  e.g: `Envar.is_set_all?(~w/HEROKU FLYIO/)` will return `false`
  if _both_ the `HEROKU` and `FLYIO` environment variables are _not_ set.
  When _all_ of the environment variables in the list are set,
  it will return `true`.
  It's the equivalent of writing:
  `Envar.is_set?("HEROKU") && Envar.is_set?("FLYIO")`.

  ## Examples
      iex> Envar.is_set_all?(["HEROKU", "AWS"])
      false

      iex> Envar.set("HELLO", "world")
      iex> Envar.set("GOODBYE", "au revoir")
      iex> Envar.is_set_all?(["HELLO",  "GOODBYE"])
      true

  """
  def is_set_all?(list) do
    Enum.all?(list, fn var -> is_set?(var) end)
  end

  @doc """
  `is_set_any/1` binary check that any
  environment variable in a `List` is defined.
  e.g: `Envar.is_set_any?(["HEROKU", "FLYIO"])` will return `false`
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

  @doc """
  `set/2` set the `value` of an environment variable `varname`.
  Accepts two `String` parameters: `varname` and `value`.

  ## Examples
      iex> Envar.set("API_KEY", "YourSuperLongAPIKey")
      :ok

  """
  @spec set(binary, binary) :: :ok
  def set(varname, value) do
    System.put_env(varname, value)
  end

  @doc """
  `load/1` load a file containing a line-separated list
  of environment variables e.g: `.env`
  Set the `value` of each environment variable.

  ## Examples
      iex> Envar.load(".env")
      :ok

  """
  @spec load(binary) :: :ok
  def load(filename) do
    # Logger.debug("File.cwd!() #{File.cwd!()}")
    path = File.cwd!() <> "/" <> filename
    Logger.debug(".env file path: #{path}")

    {:ok, data} = File.read(path)

    data
    |> String.trim()
    |> String.split("\n")
    |> Enum.each(fn line ->
      line = String.trim(line)

      with line <- String.replace(line, ["export ", "'"], ""),
           [key | rest] <- String.split(line, "="),
           value <- Enum.join(rest, "=") do
        System.put_env(key, value)
      end
    end)

    :ok
  end
end
