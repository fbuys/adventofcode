defmodule Mix.Tasks.CalculateScore do
  @moduledoc false
  @shortdoc "Calculate score for day 2 of advent of code"

  alias Two.Part1
  alias Two.Part2

  use Mix.Task

  @impl Mix.Task
  def run(_args) do
    "./input.txt"
    |> Path.expand()
    |> File.read!()
    |> String.split(~r/\n/)
    # |> Part1.tally()
    |> Part2.tally()
    |> IO.inspect(label: "############################input")
  end
end
