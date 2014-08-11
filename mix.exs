defmodule MyProject.Mixfile do
  use Mix.Project

  def project do
    [app: :my_project,
     version: "0.0.1",
     elixir: "~> 0.15.0",
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:cowboy,:plug,:emysql],
     mod: {MyProject, []}]
  end

  # Type `mix help deps` for more examples and options
  defp deps do
    [{:cowboy, github: "extend/cowboy"},
     {:plug, github: "elixir-lang/plug", tag: "v0.5.2"},
     {:emysql, github: "Eonblast/Emysql"}]
  end
end
