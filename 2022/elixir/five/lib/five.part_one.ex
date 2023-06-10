defmodule Five.PartOne do
  @crate_indexes [1, 5, 9, 13, 17, 21, 25, 29, 33]

  def move_crates([raw_stacks, raw_instructions]) do
    stacks = parse_raw_stacks(raw_stacks)

    raw_instructions
    |> parse_instructions()
    |> process_instructions(stacks)
  end

  defp parse_raw_stacks(raw_stacks) do
    raw_stacks
    |> String.split(~r/\n/)
    |> Enum.slice(0..-2//1)
    |> Enum.map(&:binary.bin_to_list(&1))
    |> parse_all_stacks()
  end

  defp parse_all_stacks(all_stacks) do
    @crate_indexes
    |> Enum.map(&parse_one_stack(&1, all_stacks))
    |> Enum.with_index(fn x, i -> %{"#{i + 1}" => x} end)
    |> Enum.reduce(%{}, fn x, acc -> Map.merge(acc, x) end)
  end

  defp parse_one_stack(crate_idx, all_stacks) do
    all_stacks
    |> Enum.reduce([], &prepend_crate_to_stack(Enum.at(&1, crate_idx), &2))
    |> Enum.reverse()
  end

  # 32 == ascii space
  defp prepend_crate_to_stack(crate, stack) when crate == 32, do: stack
  defp prepend_crate_to_stack(crate, stack), do: [crate | stack]

  defp parse_instructions(raw_instructions) do
    raw_instructions
    |> String.trim()
    |> String.split(~r/\n/)
    |> Enum.map(&parse_instruction(&1))
  end

  defp parse_instruction(raw_instruction) do
    ~r/move\s(?<count>.+)\sfrom\s(?<from>.+)\sto\s(?<dest>.+)$/
    |> Regex.named_captures(raw_instruction)
  end

  defp process_instructions(instructions, stacks) do
    instructions
    |> Enum.reduce(stacks, &process(&1, &2))

    # process(List.first(instructions), stacks)
  end

  # %{"count" => "3", "dest" => "2", "from" => "8"},

  # %{"1" => 'ZPMHR'},
  # %{"2" => 'PCJB'},
  # %{"3" => 'SNHGLCD'},
  # %{"4" => 'FTMDQSRL'},
  # %{"5" => 'FSPQBTZM'},
  # %{"6" => 'TFSZBG'},
  # %{"7" => 'NRV'},
  # %{"8" => 'PGLTDVCM'},
  # %{"9" => 'WQNJFML'}

  defp process(%{"count" => count, "dest" => dest_idx, "from" => from_idx}, stacks) do
    from_stack = Map.fetch!(stacks, from_idx)
    dest_stack = Map.fetch!(stacks, dest_idx)
    # from_stack = Map.fetch!(stacks, from_idx) |> Enum.reverse()
    # dest_stack = Map.fetch!(stacks, dest_idx) |> Enum.reverse()
    range = Range.new(1, String.to_integer(count))

    new_stacks =
      Enum.reduce(range, {from_stack, dest_stack}, fn i, {[from_h | from_rest], dest_stack} ->
        {from_rest, [from_h | dest_stack]}
      end)

    from_stack = elem(new_stacks, 0)
    dest_stack = elem(new_stacks, 1)
    # from_stack = elem(new_stacks, 0) |> Enum.reverse()
    # dest_stack = elem(new_stacks, 1) |> Enum.reverse()

    Map.merge(stacks, %{from_idx => from_stack, dest_idx => dest_stack})
  end
end
