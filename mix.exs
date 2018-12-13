defmodule Coinbase.Mixfile do
  use Mix.Project

  def project do
    [app: :coinbase_ex,
     version: "0.2.0",
     build_path: "build",
     config_path: "config/config.exs",
     deps_path: "deps",
     lockfile: "mix.lock",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [extra_applications: [:logger, :httpoison]]
  end

  defp deps do
    [{:poison, "~> 3.1.0", override: true},
     {:httpoison, "~> 1.0"}]
  end
end
