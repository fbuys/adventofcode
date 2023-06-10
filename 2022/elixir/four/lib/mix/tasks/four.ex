defmodule Mix.Tasks.Four do
  @moduledoc false
  @shortdoc "Advent of code day 4"

  use Mix.Task

  @impl Mix.Task

  def run(args) do
    "./input.txt"
    |> Path.expand()
    |> File.read!()
    |> String.trim()
    |> String.split(~r/\n/)
    |> Four.count_contained_pairs()
    |> IO.inspect(label: "#########################result", limit: :infinity)
  end
end
