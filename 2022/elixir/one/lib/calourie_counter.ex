defmodule One.CalourieCounter do
  @moduledoc false

  @spec max_count(calouries_lists :: [[String.t()]], top :: pos_integer()) :: Integer.t()
  def max_count(calouries_lists, top \\ 1) do
    calouries_lists
    |> count()
    |> Enum.sort(&(&1 >= &2))
    |> Enum.take(top)
  end

  @spec count(calouries_lists :: [[String.t()]]) :: [Integer.t()]
  def count(calouries_lists) do
    calouries_lists
    |> Enum.map(&parse_ints(&1))
    |> Enum.map(&Enum.sum(&1))
  end

  # private

  @spec parse_ints(list :: [String.t()]) :: [Integer.t()]
  defp parse_ints(list) do
    list
    |> Enum.map(&string_to_integer(&1))
  end

  @spec string_to_integer(string :: String.t()) :: Integer.t()
  defp string_to_integer(""), do: 0
  defp string_to_integer(string), do: String.to_integer(string)
end
