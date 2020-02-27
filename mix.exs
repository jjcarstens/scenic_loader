defmodule ScenicLoader.MixProject do
  use Mix.Project

  def project do
    [
      app: :scenic_loader,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:scenic, "~> 0.10"},
      {:ex_doc, ">= 0.0.0", only: [:dev, :docs]}
    ]
  end
end
