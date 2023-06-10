defmodule Three do
  @moduledoc """
  Advent of code day 3 implementation
  """

  @spec prioritize(supplies_list :: [binary()]) :: [pos_integer()]
  def prioritize(supplies_list) do
    supplies_list
    |> Enum.map(&do_prioritize(&1))
  end

  @spec do_prioritize(binary()) :: pos_integer()
  defp do_prioritize(supplies) do
    supplies
    |> split_supplies_in_two()
    |> find_duplicate_item()
    |> prioritize_item()
  end

  @spec split_supplies_in_two(binary()) :: {binary(), binary()}
  defp split_supplies_in_two(supplies) do
    size = div(String.length(supplies), 2)
    <<head::binary-size(size), rest::binary>> = supplies
    {head, rest}
  end

  @spec find_duplicate_item({binary(), binary()}) :: binary()
  defp find_duplicate_item({first, second}) do
    first
    |> String.replace(~r/(.)/, "(\\1)|")
    |> String.slice(0..-2//1)
    |> Regex.compile!()
    |> Regex.run(second)
    |> List.first("")
  end

  @doc """
    Lowercase item types a through z have priorities 1 through 26.
    Uppercase item types A through Z have priorities 27 through 52.
  """
  @spec prioritize_item(binary()) :: pos_integer()
  defp prioritize_item(""), do: 0
  defp prioritize_item(<<item::8>>) when item > ?Z, do: item - 96
  defp prioritize_item(<<item::8>>), do: item - 38
end
