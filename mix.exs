defmodule S3poller.Mixfile do
  use Mix.Project

  def project do
    [
      app: :s3poller,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
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
      {:ex_aws, "~> 1.0"},
      #{:ex_aws_s3, "~> 2.0"},  #Not in hex.pm anymore; Manual clone into deps.
      {:poison, "~> 3.0"},
      {:hackney, "~> 1.9"},
      {:sweet_xml, "~> 0.6"}
    ]
  end
end
