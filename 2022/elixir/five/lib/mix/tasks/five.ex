defmodule Mix.Tasks.Five do
  @moduledoc false
  @shortdoc "Advent of code day 4"

  use Mix.Task

  @impl Mix.Task

  def run(args) do
    "./input.txt"
    |> Path.expand()
    |> File.read!()
    |> String.split(~r/\n\n/)
    # |> Five.PartOne.move_crates()
    |> Five.PartTwo.move_crates()
    |> IO.inspect(label: "#########################result", limit: :infinity)
  end
end
