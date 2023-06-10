defmodule Three.PartTwo do
  @moduledoc """
  Advent of code day 3 implementation

  We group the supplies list in groups of 3.
  We find the badge carried by the group, the badge is the only item type carried by all three Elves
  """

  @spec prioritize(supplies_list :: [binary()]) :: [pos_integer()]
  def prioritize(supplies_list) do
    supplies_list
    |> group_supplies_list()
    |> do_prioritize()

    # |> Enum.map(&do_prioritize(&1))
  end

  defp group_supplies_list(supplies_list), do: group_supplies_list(supplies_list, [])
  defp group_supplies_list([""], acc), do: acc |> Enum.reverse()
  defp group_supplies_list([a, b, c | rest], acc) do
    group_supplies_list(rest, [[a, b, c] | acc])
    end

  # @spec do_prioritize(binary()) :: pos_integer()
  defp do_prioritize(grouped_supplies) do
    grouped_supplies
    |> Enum.map(&find_badge(&1))
    |> Enum.map(&prioritize_item(&1))
    # |> prioritize_supplies()
  #   # |> group_supplies_in_two()
  #   # |> find_duplicate_item()
  end
  #   do_prioritize(a,b,c,rest)
  # defp do_prioritize

  defp find_badge([a,b,c]) do
    a
    |> tokens_regex()
    |> Regex.scan(b)
    |> List.flatten()
    |> Enum.uniq()
    |> Enum.join()
    |> tokens_regex()
    |> Regex.run(c)
    |> List.flatten()
    |> Enum.uniq()
    |> Enum.join()
  end

  defp tokens_regex(tokens) do
    tokens
    |> String.split("")
    |> Enum.uniq()
    |> Enum.join("|")
    |> (&"([#{&1}])").()
    |> Regex.compile!()
  end

  @spec prioritize_item(binary()) :: pos_integer()
  defp prioritize_item(""), do: 0
  defp prioritize_item(<<item::8>>) when item > ?Z, do: item - 96
  defp prioritize_item(<<item::8>>), do: item - 38

  # @spec find_duplicate_item({binary(), binary()}) :: binary()
  # defp find_duplicate_item({first, second}) do
  #   first
  #   |> String.replace(~r/(.)/, "(\\1)|")
  #   |> String.slice(0..-2//1)
  #   |> Regex.compile!()
  #   |> Regex.run(second)
  #   |> List.first("")
  # end

end
