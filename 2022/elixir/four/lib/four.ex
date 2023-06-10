defmodule Four do
  @moduledoc """
  Documentation for `Four`.
  """

  @doc """
  Some of the provided pairs fully contained by the other.
  For example, 2-8 fully contains 3-7, and 6-6 is fully contained by 4-6.

  This function iterates over all pair and returns the number of contained pairs.
  """
  def count_contained_pairs(pairs) do
    pairs
    |> do_count()
  end

  defp do_count(pairs) do
    pairs
    |> Enum.map(&String.split(&1, ~r/[-,]/))
    # |> Enum.map(&is_contained(&1))
    |> Enum.map(&is_overlapping?(&1))
    |> Enum.map(fn x -> if x, do: 1, else: 0 end)
    |> Enum.sum()
  end

  defp is_overlapping?(pairs_array) do
    [min_a, max_a, min_b, max_b] = pairs_array |> Enum.map(&String.to_integer(&1))
    result = cond do
      max_a >= min_b and min_a <= max_b -> true
      max_b >= min_a and min_b <= max_a -> true
      true -> false
    end
    IO.inspect([min_a, max_a, min_b, max_b, result], label: "------------------------------is_contained")
    result
  end

  # defp is_contained(pairs_array) do
  #   [min_a, max_a, min_b, max_b] = pairs_array |> Enum.map(&String.to_integer(&1))
  #   result = cond do
  #     min_a <= min_b and max_a >= max_b -> true
  #     min_a >= min_b and max_a <= max_b -> true
  #     true -> false
  #   end
  #   IO.inspect([min_a, max_a, min_b, max_b, result], label: "------------------------------is_contained")
  #   result
  # end
end
