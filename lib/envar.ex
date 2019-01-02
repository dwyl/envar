defmodule Envar do
  @moduledoc """
  Documentation for `Envar`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> System.put_env("HELLO", "world")
      iex> Envar.get("HELLO")
      "world"

  """
  def get(varname) do
    case System.get_env(varname) do
      nil ->
        # IO.inspect(Process.info(self(), :current_stacktrace))
        IO.warn("ERROR: #{varname} Environment Variable Not Set")
        nil
      val ->
        # IO.inspect(val, label: "val")
        val
    end
  end
end
