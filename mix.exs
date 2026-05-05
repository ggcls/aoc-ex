defmodule AocEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :aoc_ex,
      version: "0.1.0",
      elixir: ">= 1.14.0",
      start_permanent: Mix.env() == :prod,
      deps: []
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  def cli do
    [
      preferred_envs: ["aoc.test": :test]
    ]
  end
end
