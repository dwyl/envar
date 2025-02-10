defmodule Envar.MixProject do
  use Mix.Project

  def project do
    [
      app: :envar,
      description: "Helpful functions for working with Environment Variables",
      version: "1.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      package: package(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        c: :test,
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.json": :test,
        "coveralls.html": :test
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # track test coverage: https://github.com/parroty/excoveralls
      {:excoveralls, "~> 0.18.0", only: [:test, :dev]},

      # Create Documentation Hex.docs: https://hex.pm/packages/ex_doc
      {:ex_doc, "~> 0.37.1", only: :dev},

      # Keep Code Tidy: https://github.com/rrrene/credo
      {:credo, "~> 1.7.0", only: [:dev, :test], runtime: false},

      # https://github.com/jeremyjh/dialyxir
      {:dialyxir, "~> 1.1", only: [:dev], runtime: false}
    ]
  end

  #  package info for publishing to Hex.pm
  defp package() do
    [
      files: ~w(lib LICENSE mix.exs README.md),
      name: "envar",
      licenses: ["GNU GPL v2.0"],
      maintainers: ["dwyl"],
      links: %{"GitHub" => "https://github.com/dwyl/envar"}
    ]
  end

  defp aliases do
    [
      c: ["coveralls.html"]
    ]
  end
end
