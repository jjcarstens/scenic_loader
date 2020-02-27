defmodule ScenicLoader.MixProject do
  use Mix.Project

  @source_url "https://github.com/jjcarstens/scenic_loader"
  @version "0.1.0"

  def project do
    [
      app: :scenic_loader,
      version: @version,
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      description: "When you just need to show a loading spinner in scenic",
      deps: deps(),
      docs: docs(),
      package: package()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp docs do
    [
      extras: ["README.md"],
      main: "readme",
      source_ref: "v#{@version}",
      source_url: @source_url
    ]
  end

  defp package do
    %{
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => @source_url}
    }
  end

  defp deps do
    [
      {:scenic, "~> 0.10"},
      {:ex_doc, ">= 0.0.0", only: [:dev, :docs]}
    ]
  end
end
