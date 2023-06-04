defmodule Mix.Tasks.CalourieCounting do
  @moduledoc false
  @shortdoc "Advent of code day 1 puzzle 1"

  use Mix.Task

  alias One.CalourieCounter

  @impl Mix.Task
  def run(_args) do
    File.read!(Path.expand("input.txt"))
    |> String.split(~r/\n\n/)
    |> Enum.map(fn x -> String.split(x, ~r/\n/) end)
    |> CalourieCounter.max_count(3)
    |> Enum.sum()
    |> IO.inspect(label: "############################################max")
  end
end
