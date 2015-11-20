defmodule Ninjaproxies.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ninjaproxies,
      version: "0.1.0",
      elixir: "~> 1.1",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      test_coverage: [tool: ExCoveralls],
      deps: deps,
      description: description,
      package: package,
      docs: [extras: ["README.md"], main: "extra-readme"]
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:httpoison, "~> 0.7"},
      {:poison, "~> 1.5"},
      {:exvcr, "~> 0.3", only: [:dev, :test]},
      {:ex_doc, "~> 0.10.0", only: [:dev, :docs]},
      {:excoveralls, "~> 0.3", only: [:dev, :test]},
      {:inch_ex, "~> 0.4.0", only: [:dev, :docs]},
      {:credo, "~> 0.1.0", only: :dev}
    ]
  end

  defp description do
    """
    Ninjaproxies client library for Elixir.
    """
  end

  defp package do
    [
      licenses: ["MIT"],
      keywords: ["Elixir", "Proxy", "Proxies", "Ninjaproxies", "REST", "HTTP"],
      maintainers: ["Zen Savona"],
      links: %{"GitHub" => "https://github.com/zensavona/ninjaproxies",
               "Docs" => "https://hexdocs.pm/ninjaproxies"}
    ]
  end
end
