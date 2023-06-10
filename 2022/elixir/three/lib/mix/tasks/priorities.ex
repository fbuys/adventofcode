defmodule Mix.Tasks.Priorities do
  @moduledoc false
  @shortdoc "Advent of code day 3"

  use Mix.Task

  @impl Mix.Task

  def run(args) do
    "./input.txt"
    |> Path.expand()
    |> File.read!()
    |> String.split(~r/\n/)
    |> Three.PartTwo.prioritize()
    |> Enum.sum()
    |> IO.inspect(label: "#########################result", limit: :infinity)
  end
end
